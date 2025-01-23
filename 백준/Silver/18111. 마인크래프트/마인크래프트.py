import sys

N, M, B = map(int, sys.stdin.readline().split())
arr = [list(map(int, sys.stdin.readline().rstrip().split())) for _ in range(N)]

heights = []
total_blocks = B
for r in range(N):
    for c in range(M):
        heights.append(arr[r][c])
        total_blocks += arr[r][c]

heights.sort()
heights.reverse()


max_h = max(heights)
min_h = min(heights)

min_time = float('inf')
bst_height = 0

for num in range(min_h, max_h + 1):
    time = 0
    blocks = B

    for height in heights:
        if height > num:
            time += 2*(height - num)
            blocks += height - num
        elif height < num:
            if num - height <= blocks:
                blocks -= num - height
                time += num - height
            else:
                time = float('inf')
                break

    if time < min_time:
        min_time = time
        bst_height = num

    elif time == min_time and num > bst_height:
        bst_height = num
print(min_time, bst_height)

"""
2 2 0
1 2
2 2

"""