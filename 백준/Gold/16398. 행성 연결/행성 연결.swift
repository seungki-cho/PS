import Foundation

let li = (0..<Int(readLine()!)!).map { _ in
    readLine()!.split(separator: " ").map{Int($0)!}
}

var adj = [(Int, Int, Int)]()
for i in 0..<li.count {
    for j in 0..<li.count {
        adj.append((i, j, li[i][j]))
    }
}
var uf = Array(repeating: -1, count: li.count)

func find(_ n: Int) -> Int {
    if uf[n] < 0 {
        return n
    }
    uf[n] = find(uf[n])
    return uf[n]
}

func union(_ a: Int, _ b: Int) {
    let (A, B) = (find(a), find(b))
    
    if A != B {
        if A > B {
            uf[A] += uf[B]
            uf[B] = A
        } else {
            uf[B] += uf[A]
            uf[A] = B
        }
    }
}

var answer = 0
adj.sorted { $0.2 < $1.2 }.forEach { (a, b, w) in
    if find(a) != find(b) {
        union(a, b)
        answer += w
    }
}

print(answer)
