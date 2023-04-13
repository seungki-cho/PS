import Foundation

let n = Int(readLine()!)!
var li = readLine()!.split(separator: " ").map { Int($0)! }
var k = li[0]
var ans = 0

for i in 1..<li.count {
    if li[i] < k {
        k = li[i]
    } else {
        ans = max(li[i] - k, ans)
    }
}

print(ans)
