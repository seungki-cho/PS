import Foundation

let N = Int(readLine()!)!
var adj = Array(repeating: [Int](), count: N)
var ans: [Int?] = Array(repeating: nil, count: N)

for _ in 0..<N-1 {
    let ab = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a, b) = (ab[0]-1, ab[1]-1)
    adj[a].append(b)
    adj[b].append(a)
}

var q = [0]

while !q.isEmpty {
    let this = q.removeFirst()
    
    for next in adj[this] {
        guard ans[next] == nil else { continue }
        ans[next] = this
        q.append(next)
    }
}

ans.removeFirst()

ans.forEach { print($0!+1) }
