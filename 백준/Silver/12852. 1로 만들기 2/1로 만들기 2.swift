import Foundation

var N = Int(readLine()!)!
var li = Array(repeating: [Int](), count: N+1)
li[N] = [N]
var q = [N]

while !q.isEmpty {
    let n = q.removeFirst()
    if n == 1 { break; }
    
    if n%3 == 0, li[n/3].isEmpty {
        li[n/3] = li[n] + [n/3]
        q.append(n/3)
    }
    if n%2 == 0, li[n/2].isEmpty {
        li[n/2] = li[n] + [n/2]
        q.append(n/2)
    }

    if n-1 > 0, li[n-1].isEmpty {
        li[n-1] = li[n] + [n-1]
        q.append(n-1)
    }
}

print(li[1].count-1)
print(li[1].map{"\($0) "}.joined())
