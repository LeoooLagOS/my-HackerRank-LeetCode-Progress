import java.io.*;
import java.util.*;

public class Solution {

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
        int n = scanner.nextInt(); // Number of lines
        
        // Create a list that holds other lists of integers
        ArrayList<ArrayList<Integer>> lines = new ArrayList<>();
        
        // Read n lines of numbers
        for (int i = 0; i < n; i++) {
            int d = scanner.nextInt(); // Number of integers in this line
            ArrayList<Integer> line = new ArrayList<>();
            for (int j = 0; j < d; j++) {
                line.add(scanner.nextInt());
            }
            lines.add(line);
        }
        
        int q = scanner.nextInt(); // Number of queries
        
        // Process q queries
        for (int i = 0; i < q; i++) {
            int x = scanner.nextInt(); // Line number
            int y = scanner.nextInt(); // Position in the line
            
            // Use a try-catch block to handle out-of-bounds errors
            try {
                System.out.println(lines.get(x - 1).get(y - 1));
            } catch (IndexOutOfBoundsException e) {
                System.out.println("ERROR!");
            }
        }
        
        scanner.close();
    }
}
