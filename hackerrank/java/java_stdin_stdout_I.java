/**
 * Problem: Java Stdin and Stdout I
 * Platform: HackerRank
 * Difficulty: Easy
 * Language: Java
 */

import java.util.Scanner;

public class java_stdin_stdout_I {  
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int a = scanner.nextInt();
        int b = scanner.nextInt();
        int c = scanner.nextInt();
        
        System.out.println(a);
        System.out.println(b);
        System.out.println(c);
        
        scanner.close();
    }
}