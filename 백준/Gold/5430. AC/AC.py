# R(뒤집기): 배열 순서 뒤집기
# D: 첫 번째 수 버리기
# 배열이 비어 있을 시에 D는 에러
# input 처리에서 16분 ㅠㅠ
# 1차 제출 33분


from collections import deque
import sys

T = int(sys.stdin.readline())
for _ in range(T):
    P = list(sys.stdin.readline().rstrip())
    n = int(sys.stdin.readline().rstrip())
    lst = sys.stdin.readline().rstrip()
    lst = lst.strip('[]')

    if lst:
        lst = deque(list(map(int, lst.split(','))))
    else:
        lst = deque(lst)

    is_reversed = False   # 뒤집어졌나요?
    is_error = False   # lst 가 비어있는데 함수 D를 실행했나요?

    for p in P:
        if is_error:  # 에러이면 에러 출력하고 반복문 break
            break
        elif p == 'R':  # 뒤집기
            if not is_reversed:  # 순차이면
                is_reversed = True  # 뒤집어주고
            else:  # 역순이면
                is_reversed = False  # 순차로 해주고
        else:   # D 함수이면
            if lst:  # lst 가 비어있지 않다면
                if is_reversed:  # 역순이라면
                    lst.pop()   # 맨 뒤에 뽑기
                else:
                    lst.popleft()
            else:  # 비어있다면
                is_error = True # 에러 발생

    if is_error: # 에러라면
        print('error')
        continue

    else:
        if is_reversed:  # 역순 상태라면
            lst.reverse()
    print("", end="[")
    for i in range(len(lst)):
        if (i == len(lst)-1):
            print(lst[i], end="")
        else:
            print(lst[i], end=",")

    print("]")
    


"""
1
D
2
[2, 22]

"""