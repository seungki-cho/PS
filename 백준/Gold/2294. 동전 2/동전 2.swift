import Foundation

let nk = readLine()!.split{$0==" "}.map{Int($0)!}
let (n, k) = (nk[0], nk[1])

var dp = Array(repeating: Int.max, count: k+1)

for _ in 0..<n {
    let this = Int(readLine()!)!
    if this > k { continue }
    dp[this] = 1
}

for i in 1...k where dp[i] != Int.max {
    for j in 1..<k where i * j <= k {
        dp[i*j] = min(dp[i*j], dp[i] * j)
    }
    for j in 1..<i where dp[j] != Int.max && i+j <= k {
        dp[i+j] = min(dp[i+j], dp[i] + dp[j])
    }
}
print(dp[k] == Int.max ? -1 : dp[k])
