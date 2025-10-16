import textwrap

def wrap(string, max_width):
    # The textwrap.fill() function does exactly what the problem asks for.
    # It wraps a single paragraph of text to a certain width.
    return textwrap.fill(string, max_width)

if __name__ == '__main__':
    string, max_width = input(), int(input())
    result = wrap(string, max_width)
    print(result)
