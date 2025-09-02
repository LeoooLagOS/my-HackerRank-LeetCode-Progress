"""
Problem: Python If-Else
Platform: HackerRank
Difficulty: Easy
Language: Python
"""

if __name__ == '__main__':
    n = int(input().strip())
    
    # Check if n is odd
    if n % 2 != 0:
        print("Weird")
    else:
        # For even numbers, check specific ranges
        if n >= 2 and n <= 5:
            print("Not Weird")
        elif n >= 6 and n <= 20:
            print("Weird")
        else:
            print("Not Weird")