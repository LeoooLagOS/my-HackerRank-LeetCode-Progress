/**
 * Problem: Playing With Characters
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: C
 */

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

int main() {
    // Declare a character, a string for the word, and a string for the sentence
    char ch;
    char s[100];
    char sen[100];
    
    // Read the single character
    scanf("%c", &ch);
    
    // Read the string (word)
    scanf("%s", s);
    
    // Consume the newline character left by the previous scanf
    // and then read the entire sentence until a new newline is found.
    scanf(" %[^\n]%*c", sen);
    
    // Print the collected inputs, each on a new line
    printf("%c\n", ch);
    printf("%s\n", s);
    printf("%s\n", sen);
    
    return 0;
}
