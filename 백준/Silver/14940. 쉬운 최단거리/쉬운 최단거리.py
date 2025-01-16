from collections import deque
import sys

N, M = map(int, sys.stdin.readline().split())
li = []
q = deque()

for i in range(N):
    row = list(map(int, input().split()))
    li.append(row)
    for j in range(M):
        if row[j] == 2:
            q.append((i, j, 0))

ix = [0, 0, 1, -1]
iy = [1, -1, 0, 0]

isv = [[0] * M for _ in range(N)]

while q:
    r, c, w = q.popleft()

    for i in range(4):
        nr = r + ix[i]
        nc = c + iy[i]

        if nr < 0 or nc < 0 or nr >= N or nc >= M:
            continue

        if isv[nr][nc] != 0 or li[nr][nc] != 1:
            continue

        isv[nr][nc] = w + 1
        q.append((nr, nc, w + 1))

for i in range(N):
    for j in range(M):
        if li[i][j] == 1 and isv[i][j] == 0:
            print(-1, end=" ")
        else:
            print(isv[i][j], end=" ")
    print()