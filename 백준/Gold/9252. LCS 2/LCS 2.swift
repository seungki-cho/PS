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
var (i, j) = (b.count, a.count)
var ret = ""
while lcs[i][j] != 0 {
    if lcs[i][j] == lcs[i-1][j] {
        i = i-1
    } else if lcs[i][j] == lcs[i][j-1]{
        j = j-1
    } else {
        (i, j) = (i-1, j-1)
        ret += "\(a[j])"
    }
}
if ret.count == 0 {
    print(0)
    exit(0)
}
print(ret.count)
print(String(ret.reversed()))
