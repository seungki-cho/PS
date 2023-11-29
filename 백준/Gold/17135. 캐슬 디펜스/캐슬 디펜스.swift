import Foundation

let nmd = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M, D) = (nmd[0], nmd[1], nmd[2])
let li = (0..<N).map { _ in readLine()!.split{$0==" "}.map{Int($0)!} }
var pos = [Int]()
var enemy = [(Int, Int)]()
for i in 0..<M {
    for j in (0..<N).reversed() {
        if li[j][i] == 1 { enemy.append((j, i))}
    }
}

var ans = 0

func distance(_ x: Int, _ y: Int, _ p: Int) -> Int {
    abs(x - N) + abs(y - p)
}
func isInbound(_ x: Int, _ y: Int, _ p: Int) -> Bool{
    x < N && (abs(x - N) + abs(y - p) <= D)
}

func solution(_ pos: [Int]) {
    var jobs = Set<Int>()
    var localEnemy = enemy

    for k in 0..<N {
        for i in 0..<3 {
            guard let mins = localEnemy.filter { $0.0 < N }.map { distance($0.0, $0.1, pos[i]) }.min() else { continue }
            if let (x, y) = localEnemy.filter({ isInbound($0.0, $0.1, pos[i]) && distance($0.0, $0.1, pos[i])==mins}).first {
                jobs.insert("\(x-k)\(y)".hashValue)
            }
        }
        for i in 0..<localEnemy.count {
            if jobs.contains("\(localEnemy[i].0 - k)\(localEnemy[i].1)".hashValue) {
                localEnemy[i] = (1234567, 1234567)
            }
            localEnemy[i] = (localEnemy[i].0 + 1, localEnemy[i].1)
        }
    }
    ans = max(jobs.count, ans)
}

func myFunc() {
    if pos.count == 3 {
        solution(pos)
        return
    }
    for i in (pos.last ?? 0)..<M where !pos.contains(i) {
        pos.append(i)
        myFunc()
        pos.removeLast()
    }
}

myFunc()
print(ans)
