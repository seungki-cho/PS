import Foundation
let n = Int(readLine()!)!
let li = readLine()!.split{$0==" "}.map{Int($0)!}
let m = Int(readLine()!)!
var sums = Array(repeating: 0, count: n+1)

for i in 1...n {
    sums[i] = sums[i-1] + li[i-1]
}
var msums = [Int]()
for i in m...n {
    msums.append(sums[i] - sums[i-m])
}

var dp = Array(repeating: Array(repeating: 0, count: 3), count: msums.count)
dp[0][0] = msums[0]

for i in 1..<msums.count {
    dp[i][0] = max(dp[i-1][0], msums[i])
    if i-m >= 0 {
        dp[i][1] = max(dp[i-m][0] + msums[i], dp[i-1][1])
        dp[i][2] = max(dp[i-m][1] + msums[i], dp[i-1][2])
    }
}
print(dp[dp.count-1][2])