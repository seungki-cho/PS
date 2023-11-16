import Foundation
let N = Int(readLine()!)!
var adj = Array(repeating: [Int](), count: N)
var d = Array(repeating: 0, count: N)
var times = [Int]()
for to in (0..<N) {
    let a = readLine()!.split{$0==" "}.map{Int($0)!}
    times.append(a[0])
    if a.count == 2 { continue }
    for i in (2...a.count-1) {
        let from = a[i]-1
        adj[from].append(to)
        d[to] += 1
    }
}

var ans = Array(repeating: 0, count: N)
var q = [Int]()
for i in 0..<N {
    if d[i] == 0 {
        q.append(i)
        ans[i] = times[i]
    }
}

while !q.isEmpty {
    let from = q.removeLast()
    adj[from].forEach { to in
        ans[to] = max(ans[from], ans[to])
        d[to] -= 1
        if d[to] == 0 {
            ans[to] += times[to]
            q.append(to)
        }
    }
}
print(ans.max()!)
