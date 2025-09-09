import java.util.HashMap;
import java.util.Map;

class Solution {
    public int[] twoSum(int[] nums, int target) {
        // A HashMap to store number -> index pairs
        Map<Integer, Integer> seen = new HashMap<>();

        for (int i = 0; i < nums.length; i++) {
            int complement = target - nums[i];

            // Check if the map contains the complement we need
            if (seen.containsKey(complement)) {
                // If it does, return a new array with the two indices
                return new int[] { seen.get(complement), i };
            }

            // If not, add the current number and its index to the map
            seen.put(nums[i], i);
        }

        // This part is for cases where no solution is found.
        throw new IllegalArgumentException("No two sum solution");
    }
}
