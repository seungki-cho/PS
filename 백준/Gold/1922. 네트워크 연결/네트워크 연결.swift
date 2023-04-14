import Foundation
let n = Int(readLine()!)!
var adj = [(Int, Int, Int)]()
let li = (0..<Int(readLine()!)!).map { _ in
    let abc = readLine()!.split(separator: " ").map{Int($0)!}
    adj.append((abc[0], abc[1], abc[2]))
}
if n == 1 {
    print(0)
    exit(0)
}

var uf = Array(repeating: -1, count: n+1)

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
