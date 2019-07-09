// boot2.c の代わり

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

// 関数 boot2() より前に他の関数の定義(実装)や、大域変数宣言を書いてはいけない
int kbd_handler();
int register_kbd_handler();
int print(int num, int x, int y, int color);
int in8(int port);
int out8(int port, int value);
int sti();
int cli();
int halt();
int sti_and_halt();

void boot2() {

  /* 
  while ((in8(KBD_STATUS) & 1) == 0)
    ;
  int value = in8(KBD_DATA); //KBD_DATAの値を取得する, 16進数で
  int key = value & 0x7f;
  
  if(1 <= key - 1 && key - 1 <= 9)
    print(key-1, 100, 50, 15);
  else
    print(0, 100, 50, 15);
  while((in8(KBD_STATUS) & 1) == 0)
    ;
  int value2 = in8(KBD_DATA);
  int key2 = value2 & 0x7f;

  if(1 <= key2 - 1 && key2 - 1 <= 9)
    print(key2-1, 150, 50, 15);
  else
    print(0, 150, 50, 15);

  halt();
*/
  register_kbd_handler();
  while(1){
    halt();
  }
}

// 関数の宣言は省略する。
// C89 までは、戻り値が int である関数は事前に宣言しなくてもよかった。
// 適当な戻り値がない場合は 0 を返すことにする。

int xpos = 100;

int kbd_handler() {
  out8(0x20, 0x61);	// PIC0_OCW2: accept IRQ1 again
  int value = in8(KBD_DATA);

  // 表示: ここを書き換えればよい
  int key = value & 0x7f;
  if(1 <= key - 1 && key - 1 <= 9)
    print(key - 1, xpos, 50, 15);
  else
    print(0, xpos, 50, 15);
  xpos += 5;
}

// 割り込み処理関数を登録する
int register_kbd_handler() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  sti();
  out8(0x21, 0xf9);	// PIC0_IMR: accept only IRQ1 and IRQ2 (PIC1)
  out8(0xa1, 0xff);	// PIC1_IMR: no interrupt
}

int print(int num, int x, int y, int color) {
  static char bitmaps[11][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	// 0
    { 0x00, 0x41, 0xff, 0x01 },	// 1
    { 0x9e, 0x92, 0x92, 0xf2},// 2
    { 0x92, 0x92, 0x92, 0xfe},// 3
    { 0xf8, 0x08, 0x08, 0xff},// 4
    { 0xf2, 0x92, 0x92, 0x9e},// 5
    { 0xfe, 0x12, 0x12, 0x1e},// 6
    { 0xe0, 0x80, 0x80, 0xfe},// 7
    { 0xfe, 0x92, 0x92, 0xfe},// 8
    { 0xf0, 0x90, 0x90, 0xfe},// 9
  };

  int i, j;
  char* vram = (char*)0xa0000;
  char* map = bitmaps[num];
  vram += (y * SCREEN_WIDTH + x);

  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      char bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + j) = color;
    }

    vram += SCREEN_WIDTH;
  }

  return 0;
}

// in 命令で port の値 (8bit) を読む
int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=a" (value) : "d" (port));
  return value;
}

// out 命令で port に値 (8bit) を書き込む
int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

// sti 命令 (割り込み許可) を実行
int sti() {
  asm volatile ("sti");
  return 0;
}

// cli 命令 (割り込み禁止) を実行
int cli() {
  asm volatile ("cli");
  return 0;
}

// hlt 命令でプロセッサを停止させる
int halt() {
  asm volatile ("hlt");
  return 0;
}

// sti 命令と hlt 命令を連続して実行
// sti してから hlt までのわずかの時間に割り込みが発生しないようにする。
int sti_and_halt() {
  asm volatile ("sti\n\thlt");
  return 0;
}
