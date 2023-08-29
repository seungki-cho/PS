import Foundation

var count = 0
let N = Int(readLine()!)!
for i in 0..<N {
    var n = Int(readLine()!)!
    if i == N-1 {
        count += n
    } else {
        count += n-1
    }
}

print(count)
