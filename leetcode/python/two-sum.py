from typing import List

class Solution:
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        # A dictionary to store numbers we've seen and their indices
        seen = {}  # Format: {number: index}

        for i, num in enumerate(nums):
            complement = target - num
            
            # Check if the complement we need is already in our dictionary
            if complement in seen:
                # If it is, we have found the solution
                return [seen[complement], i]
            
            # If the complement is not found, add the current number
            # and its index to the dictionary for future checks.
            seen[num] = i
