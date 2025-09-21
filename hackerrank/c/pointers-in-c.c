/**
 * Problem: Pointers in C
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: C
 */

#include <stdio.h>
#include <stdlib.h> // Required for the abs() function

void update(int *a, int *b) {
    // Store the original value of 'a' in a temporary variable
    int temp_a = *a;
    
    // Update the value at address 'a' to be the sum
    *a = *a + *b;
    
    // Update the value at address 'b' to be the absolute difference
    // of the ORIGINAL values.
    *b = abs(temp_a - *b);
}

// HackerRank provides the main function
int main() {
    int a, b;
    int *pa = &a, *pb = &b;
    
    scanf("%d %d", &a, &b);
    update(pa, pb);
    printf("%d\n%d", a, b);

    return 0;
} EOF
