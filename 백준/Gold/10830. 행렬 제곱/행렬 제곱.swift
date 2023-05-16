let NB = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, B) = (NB[0], NB[1])
var dp = [[[Int]]]()
var li = [[Int]]()

for _ in 0..<N {
    li.append(readLine()!.split{$0==" "}.map{Int($0)!})
}

func mul(_ a: [[Int]], _ b: [[Int]]) -> [[Int]] {
    var ans = Array(repeating: Array(repeating: 0, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N {
            for k in 0..<N {
                ans[i][j] += (a[i][k] * b[k][j])
            }
            ans[i][j] %= 1000
        }
    }
    return ans
}
dp.append(li)
dp.append(li)
var (i, two) = (1, 1)

while two*2 <= B {
    dp.append(mul(dp[i], dp[i]))
    two *= 2
    i += 1
}
var b = B - two
var ans = dp.last!
two = two/2
i -= 1

while b > 0 {
    if b - two >= 0 {
        b -= two
        ans = mul(ans, dp[i])
    } else {
        i -= 1
        two = two/2
    }
}

for i in 0..<N {
    for j in 0..<N {
        print(ans[i][j]%1000, terminator: " ")
    }
    print()
}
print()

/*
3 1
1 2 3
4 5 6
7 8 9
 
 1 0 0 0 1
 1 0 0 0 1
 1 0 0 0 1
 1 0 0 0 1
 1 0 0 0 1
 */
