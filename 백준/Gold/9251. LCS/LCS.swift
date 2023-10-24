import Foundation

let (a, b) = (Array(readLine()!), Array(readLine()!))
var lcs = Array(repeating: Array(repeating: 0, count: a.count+1), count: b.count+1)
for i in 1..<lcs.count {
    for j in 1..<lcs[0].count {
        if a[j-1] == b[i-1] {
            lcs[i][j] = lcs[i-1][j-1] + 1
        } else {
            lcs[i][j] = max(lcs[i-1][j], lcs[i][j-1])
        }
    }
}
print(lcs[b.count][a.count])
