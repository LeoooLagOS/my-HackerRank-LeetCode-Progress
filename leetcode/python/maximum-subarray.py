from typing import List

class Solution:
    def maxSubArray(self, nums: List[int]) -> int:
        # Kadane's Algorithm
        
        # Initialize max_so_far with the first element, as a subarray
        # must contain at least one number.
        max_so_far = nums[0]
        current_max = 0

        for num in nums:
            # Add the current number to the current subarray sum.
            current_max += num
            
            # If the current subarray sum is greater than our all-time max, update it.
            if current_max > max_so_far:
                max_so_far = current_max
            
            # If the current subarray sum ever becomes negative, reset it to 0.
            # A negative prefix will never help maximize a future subarray.
            if current_max < 0:
                current_max = 0
                
        return max_so_far
