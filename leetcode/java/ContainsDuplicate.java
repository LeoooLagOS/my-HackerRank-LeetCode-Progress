import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean containsDuplicate(int[] nums) {
        // Use a HashSet to store the numbers we have seen so far.
        // A HashSet only allows unique elements and provides O(1) average time complexity for add/contains.
        Set<Integer> seen = new HashSet<>();
        
        // Iterate through each number in the input array.
        for (int num : nums) {
            // The .add() method returns 'false' if the element is already in the set.
            // If we fail to add the number, it means we've seen it before.
            if (!seen.add(num)) {
                return true; // Duplicate found.
            }
        }
        
        // If the loop completes, no duplicates were found.
        return false;
    }
}
