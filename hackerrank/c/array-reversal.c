/**
 * Problem: Array Reversal
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: C
 */

#include <stdio.h>
#include <stdlib.h>

int main() {
    int num, *arr, i;
    scanf("%d", &num); // Read the size of the array

    // Allocate memory for the array dynamically
    arr = (int*) malloc(num * sizeof(int));
    
    // Read the elements of the array
    for(i = 0; i < num; i++) {
        scanf("%d", arr + i);
    }

    // Two-Pointer Swap Algorithm to reverse the array in-place
    int left = 0;
    int right = num - 1;
    while (left < right) {
        // Classic three-step swap
        int temp = arr[left];
        arr[left] = arr[right];
        arr[right] = temp;
        
        left++;
        right--;
    }

    // Print the reversed array
    for(i = 0; i < num; i++) {
        printf("%d ", *(arr + i));
    }
    
    // Free the dynamically allocated memory
    free(arr);
    
    return 0;
}
