/**
 * Problem: Java If-Else
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: Java
 * 
 * Task: Given an integer n, perform conditional actions:
 * - If n is odd, print "Weird"
 * - If n is even and in range 2-5, print "Not Weird" 
 * - If n is even and in range 6-20, print "Weird"
 * - If n is even and greater than 20, print "Not Weird"
 */

import java.util.Scanner;

public class java_if_else {
    public static void main(String[] args) {
        // Create Scanner object for input
        Scanner scanner = new Scanner(System.in);
        
        // Read integer input
        int n = scanner.nextInt();
        
        // Close scanner to prevent resource leaks
        scanner.close();
        
        // Check if n is odd
        if (n % 2 != 0) {
            System.out.println("Weird");
        } else {
            // n is even - check specific ranges
            if (n >= 2 && n <= 5) {
                System.out.println("Not Weird");
            } else if (n >= 6 && n <= 20) {
                System.out.println("Weird");
            } else {
                System.out.println("Not Weird");
            }
        }
    }
}