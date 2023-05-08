import Foundation

let n = Int(readLine()!)!
var li = readLine()!.split(separator: " ").map{Int($0)!}
var dp = Array(repeating: Array(repeating: 0, count: 21), count: n)
dp[0][li[0]] = 1

for i in 1..<n {
    for j in 0...20 where dp[i-1][j] != 0 {
        if 20 >= j + li[i] {
            dp[i][j + li[i]] += dp[i-1][j]
        }
        if 0 <= j - li[i] {
            dp[i][j - li[i]] += dp[i-1][j]
        }
    }

}
print(dp[n-2][li[n-1]])
