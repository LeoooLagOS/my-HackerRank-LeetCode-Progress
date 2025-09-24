if __name__ == '__main__':
    N = int(input())
    # Initialize an empty list
    my_list = []
    
    for _ in range(N):
        # Read the command and split it into parts
        command = input().split()
        cmd = command[0]
        
        if cmd == "insert":
            # Convert arguments to integers and call the insert method
            position = int(command[1])
            value = int(command[2])
            my_list.insert(position, value)
        elif cmd == "print":
            print(my_list)
        elif cmd == "remove":
            value = int(command[1])
            my_list.remove(value)
        elif cmd == "append":
            value = int(command[1])
            my_list.append(value)
        elif cmd == "sort":
            my_list.sort()
        elif cmd == "pop":
            my_list.pop()
        elif cmd == "reverse":
            my_list.reverse()
