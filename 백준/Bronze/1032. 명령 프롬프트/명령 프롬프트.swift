import Foundation
var li = (0..<Int(readLine()!)!).map { _ in
    Array(readLine()!)
}
let n = li[0].count
var bools = Array(repeating: false, count: n)
for i in (0..<n) {
    var this = li[0][i]
    for j in 0..<li.count {
        if this != li[j][i] {
            bools[i] = true
        }
    }
}


for i in 0..<n {
    print(!bools[i] ? li[0][i] : "?", terminator: "")
}
