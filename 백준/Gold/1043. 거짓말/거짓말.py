import sys


def find(n):
    if parents[n] == -1:
        return n
    parents[n] = find(parents[n])
    return parents[n]


def union(a, b):
    A = find(a)
    B = find(b)

    if A != B:
        parents[B] = A


N, M = map(int, sys.stdin.readline().split())
know = sys.stdin.readline().split()

parents = [-1]*(N+1)  # 부모의 부모 확인용

if know[0] == '0':
    print(M)
    exit(0)

know_pp = list(map(int, know[1:]))  # 아는 사람들 번호

if len(know_pp) > 1:
    for i in range(1, len(know_pp)):
        union(know_pp[0], know_pp[i])

parties = []  # 입력값 저장용


# 부모의 부모 찾는용
for _ in range(M):
    party = list(map(int, sys.stdin.readline().split()))
    parties.append(party)

for party in parties:
    if party[0] > 1:
        for i in range(2, party[0]+1):
            union(party[1], party[i])

result = 0
for party in parties:
    is_possible = True
    for i in range(1, party[0]+1):
        if find(party[i]) == find(know_pp[0]):
            is_possible = False
            break
    if is_possible:
        result += 1

print(result)