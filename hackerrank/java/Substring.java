import java.io.*;
import java.util.*;
import java.text.*;
import java.math.*;
import java.util.regex.*;

public class Solution {

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        String S = in.next();
        int start = in.nextInt();
        int end = in.nextInt();
        
        // Extract and print the substring from the start index (inclusive)
        // to the end index (exclusive).
        System.out.println(S.substring(start, end));
    }
}
