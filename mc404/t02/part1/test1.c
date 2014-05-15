#include <stdio.h>

extern unsigned int arm_strtou(const char *str);

int main() {
    char *word = "0x1f3"
    unsigned int number = arm_strtou(word);
    printf("Number is: %p\n");
    return 0;
}