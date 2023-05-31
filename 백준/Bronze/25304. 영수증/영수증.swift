import Foundation

var n = Int(readLine()!)!
let t = Int(readLine()!)!
for _ in 0..<t{
    let ab = readLine()!.split(separator: " ").map{Int($0)!}
    n -= ab[0]*ab[1]
}

print(n == 0 ? "Yes" : "No")

