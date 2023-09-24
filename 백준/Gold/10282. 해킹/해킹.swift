import Foundation

for _ in (0..<Int(readLine()!)!) {
    let ndc = readLine()!.split{$0==" "}.map{Int($0)!}
    let (n, d, c) = (ndc[0], ndc[1], ndc[2]-1)
    var adj = [Int: [(Int, Int)]]()
//    var mat = Array(repeating: Array(repeating: Int.max, count: n), count: n)
    (0..<d).forEach { _ in
        let abs = readLine()!.split{$0==" "}.map{Int($0)!}
        let (b, a, s) = (abs[0]-1, abs[1]-1, abs[2])
        
//        mat[a][b] = s
        if adj[a] != nil {
            adj[a]!.append((b, s))
        } else {
            adj[a] = [(b, s)]
        }
    }
    
    var q = [c]
    var times = Array(repeating: Int.max, count: n)
    times[c] = 0
    
    while !q.isEmpty {
        let this = q.removeFirst()
//        for i in (0..<n) where mat[this][i] != Int.max {
//            let b = mat[this][i]
//            if times[this] + b < times[i] {
//                times[i] = times[this] + b
//                q.append(i)
//            }
//        }
        adj[this]?.forEach { b, s in
            if times[this] + s < times[b] {
                times[b] = times[this] + s
                q.append(b)
            }
        }
    }
    
    let ans = times.filter { $0 != Int.max }
    print(ans.count, ans.max()!)
}
