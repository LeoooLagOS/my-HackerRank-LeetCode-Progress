/**
 * Problem: Sum and Difference of Two Numbers
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: C
 */

#include <stdio.h>

int main() {
    int int1, int2;
    float float1, float2;
    
    // Read the two integers
    scanf("%d %d", &int1, &int2);
    
    // Read the two floats
    scanf("%f %f", &float1, &float2);
    
    // Print the sum and difference of the integers
    printf("%d %d\n", int1 + int2, int1 - int2);
    
    // Print the sum and difference of the floats to one decimal place
    printf("%.1f %.1f\n", float1 + float2, float1 - float2);
    
    return 0;
}
