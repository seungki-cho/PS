import Foundation

let N = Int(readLine()!)!
var pi = readLine()!.split{$0==" "}.map{Int($0)!}
let M = Int(readLine()!)!
var dp = Array(repeating: "", count: 51)

func compare(_ A: String, _ B: String) -> String{
    var (a,b) = (A.map{String($0)}, B.map{String($0)})
    while !a.isEmpty, a.first == "0" { a.removeFirst() }
    while !b.isEmpty, b.first == "0" { b.removeFirst() }
    
    if a.count != b.count { return a.count > b.count ? A : B }
    for i in 0..<a.count {
        if a[i] != b[i] { return a[i] > b[i] ? A : B }
    }
    if A == "" {
        return A != "" ? A : B
    }
    return A
}
for i in (1...M).reversed() {
    for j in 0..<N where i - pi[j] >= 0 {
        dp[i-pi[j]] = compare(dp[i]+"\(j)", dp[i-pi[j]])
    }
}
var ans = ""
for i in 0..<dp.count {
    ans = compare(ans, dp[i])
}

print(ans.filter { $0 == "0" }.count == ans.count ? "0" : ans)
