if __name__ == '__main__':
    n = int(input())
    # Read the line of space-separated integers and map them to int
    integer_list = map(int, input().split())
    
    # Create a tuple from the map object
    t = tuple(integer_list)
    
    # Print the hash of the tuple
    print(hash(t))
