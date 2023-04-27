import Foundation

let ns = readLine()!.split{$0==" "}.map{Int($0)!}
let (n, s) = (ns[0], ns[1])
let li = readLine()!.split(separator: " ").map{Int($0)!}
var dp = Array(repeating: 0, count: n+1)

for i in 0..<li.count{
    dp[i+1] = li[i] + dp[i]
}

var (a, b) = (0, 1)
var ans = Int.max
while a <= b && b <= n {
    if a == b {
        b += 1
        continue
    }
    let this = dp[b] - dp[a]
    if this >= s {
        ans = min(ans, b-a)
        a += 1
    } else {
        b += 1
    }
}
print(ans == Int.max ? 0 : ans)
