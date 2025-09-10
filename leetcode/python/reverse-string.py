from typing import List

class Solution:
    def reverseString(self, s: List[str]) -> None:
        """
        Reverses a list of characters in-place using the two-pointer method.
        """
        left, right = 0, len(s) - 1

        while left < right:
            # Python's elegant one-line swap
            s[left], s[right] = s[right], s[left]
            
            # Move pointers towards the center
            left += 1
            right -= 1
