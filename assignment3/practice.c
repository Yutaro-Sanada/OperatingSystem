#include <stdio.h>
#include <stdlib.h>

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

int main(){
    int value = 48;
    printf("%d\n", value);//48
    int key = value & 0x7f;
    printf("%d\n", key);
    return 0;
}