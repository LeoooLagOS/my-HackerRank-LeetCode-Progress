#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>

int main() {
    int n;
    // Read the size of the array
    scanf("%d", &n);
    
    // Dynamically allocate memory for n integers
    int *arr = (int*)malloc(n * sizeof(int));
    
    // Check if memory allocation was successful
    if (arr == NULL) {
        return 1; // Exit if memory could not be allocated
    }
    
    int sum = 0;
    // Loop to read elements into the array and calculate the sum
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
        sum += arr[i];
    }
    
    // Print the final sum
    printf("%d\n", sum);
    
    // Free the dynamically allocated memory
    free(arr);
    
    return 0;
}
