 import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) {
        
        Scanner sc=new Scanner(System.in);
        String A=sc.next();
        String B=sc.next();
        
        // 1. Sum the lengths of A and B
        System.out.println(A.length() + B.length());
        
        // 2. Compare the strings lexicographically
        if (A.compareTo(B) > 0) {
            System.out.println("Yes");
        } else {
            System.out.println("No");
        }
        
        // 3. Capitalize the first letter of each string and print them
        String capA = A.substring(0, 1).toUpperCase() + A.substring(1);
        String capB = B.substring(0, 1).toUpperCase() + B.substring(1);
        System.out.println(capA + " " + capB);
        
    }
}
