import Foundation

let n = Int(readLine()!)!
var li = readLine()!.split(separator: " ").map{Int($0)!}
var dp = Array(repeating: -100_000*1000, count: n)
var ddp = Array(repeating: -100_000*1000, count: n)

dp[0] = li[0]
ddp[0] = 0
var ans = li[0]

for i in 1..<n {
    dp[i] = li[i] + max(dp[i-1], 0)
    ddp[i] = max(dp[i-1], ddp[i-1]+li[i])
    ans = [ans, dp[i], ddp[i]].max()!
}

//print(dp)
//print(ddp)

print(ans)
