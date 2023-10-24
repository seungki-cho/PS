import Foundation

let (a, b, c) = (Array(readLine()!), Array(readLine()!), Array(readLine()!))
var li = Array(repeating: Array(repeating: Array(repeating: 0, count: c.count+1), count: b.count+1), count: a.count+1)
for i in 1...a.count {
    for j in 1...b.count {
        for k in 1...c.count {
            if a[i-1] == b[j-1] && b[j-1] == c[k-1] {
                li[i][j][k] = li[i-1][j-1][k-1] + 1
            } else {
                li[i][j][k] = max(li[i-1][j][k], max(li[i][j-1][k], li[i][j][k-1]))
            }
        }
    }
}
print(li[a.count][b.count][c.count])
