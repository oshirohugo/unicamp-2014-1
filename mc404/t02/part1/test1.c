#include <stdio.h>
#include <stdlib.h>

extern unsigned int arm_strtou(const char *str);
extern void arm_utostr(unsigned int value, char *buf); 
extern int arm_strcmp(const char *s1, const char *s2);
extern unsigned int arm_strlen(const char *buf);
extern void arm_memcpy(char *dest, const char *src, unsigned int num);

int main() {
    char *word = "hugo";
    char *other = "hugoKiyodiOshiro";
    char *copy = (char *) malloc(sizeof(char) * 5);
    char *hexadecimal = "0x123abc";
    char *decimal = "12503";
    char *numberString = (char *) malloc(sizeof(char) * 5);
    unsigned int len;
    unsigned int number;
    int compare;
    unsigned int number2String = 3514;
    
    len = arm_strlen(hexadecimal);
    printf("Len is: %d\n", len);
    
    compare = arm_strcmp(word, other);        
    printf("Compare res. is: %d\n", compare);
    
    arm_memcpy(copy, other, 16);
    printf("Copied word: %s\n", copy);
    
    number = arm_strtou(hexadecimal);
    printf("Number representation: %x\n", number);
    
    number = arm_strtou(decimal);
    printf("Number representation: %d\n", number);
    
    arm_utostr(number2String, numberString);
    printf("String representation: %s\n", numberString);
    
    
    return 0;
}
