from typing import List

class Solution:
    def isPalindrome(self, s: str) -> bool:
        left, right = 0, len(s) - 1

        while left < right:
            # Move left pointer if it's not an alphanumeric character
            if not s[left].isalnum():
                left += 1
                continue
            
            # Move right pointer if it's not an alphanumeric character
            if not s[right].isalnum():
                right -= 1
                continue

            # Compare the two characters (ignoring case)
            if s[left].lower() != s[right].lower():
                return False
            
            # Move pointers inward
            left += 1
            right -= 1
            
        return True
