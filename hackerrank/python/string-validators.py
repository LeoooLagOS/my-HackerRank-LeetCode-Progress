if __name__ == '__main__':
    s = input()
    
    # The 'any()' function returns True if at least one element in an iterable is True.
    # We use a generator expression (c.isalnum() for c in s) for efficiency.
    
    print(any(c.isalnum() for c in s))
    print(any(c.isalpha() for c in s))
    print(any(c.isdigit() for c in s))
    print(any(c.islower() for c in s))
    print(any(c.isupper() for c in s))
