import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M) = (nm[0], nm[1])
var li = (0..<N).map { _ in readLine()!.map{Int(String($0))! }}
var dp = Array(repeating: Array(repeating: 0, count: M+1), count: N+1)

var ans = 0

for i in 1..<N+1 {
    for j in 1..<M+1 where li[i-1][j-1] == 1{
        dp[i][j] = min(min(dp[i-1][j], dp[i][j-1]), dp[i-1][j-1])+1
    }
}
let a = dp.flatMap { $0.flatMap{$0}}.max()!
print(a*a)
