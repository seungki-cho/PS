import Foundation
class Heap<T> {
    var heap = [T]()
    var compare: (T, T) -> Bool
    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }
    func p(_ n: Int) -> Int { (n - 1) / 2 }
    func l(_ n: Int) -> Int { n * 2 + 1 }
    func r(_ n: Int) -> Int { (n + 1) * 2}
    var isEmpty: Bool {
        heap.isEmpty
    }
    func append(_ elem: T) {
        heap.append(elem)
        var point = heap.count - 1
        while point != 0 {
            if compare(heap[point], heap[p(point)]) {
                heap.swapAt(point, p(point))
                point = p(point)
            } else {
                break
            }
        }
    }
    func pop() -> T {
        heap.swapAt(0, heap.count-1)
        let ret = heap.removeLast()
        var point = 0
        while r(point) < heap.count {
            if compare(heap[l(point)], heap[r(point)]) {
                if compare(heap[l(point)], heap[point]) {
                    heap.swapAt(l(point), point)
                    point = l(point)
                } else {
                    break
                }
            } else {
                if compare(heap[r(point)], heap[point]) {
                    heap.swapAt(r(point), point)
                    point = r(point)
                } else {
                    break
                }
            }
        }
        if l(point) == heap.count - 1, compare(heap[l(point)], heap[point]) {
            heap.swapAt(l(point), point)
        }
        return ret
    }
}
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M) = (nm[0], nm[1])
let compare: ((Int, Int), (Int, Int)) -> Bool = { $0.0 == $1.0 ? ($0.1 < $1.1) : ($0.0 < $1.0) }
let heap = Heap<(Int, Int, Int, Int)>{ compare(($0.2, $0.3), ($1.2, $1.3)) }
var cost = Array(repeating: Array(repeating: (Int.max, Int.max), count: M), count: N)
let li = (0..<N).map { _ in readLine()!.map{String($0)} }
var start = (0, 0)
var end = (0, 0)

for i in 0..<N {
    for j in 0..<M {
        if li[i][j] == "S" { start = (i, j) }
        if li[i][j] == "F" { end = (i, j) }
    }
}
heap.append((start.0, start.1, 0, 0))
while !heap.isEmpty {
    let (fromx, fromy, aw, bw) = heap.pop()
    if compare(cost[fromx][fromy], (aw, bw)) { continue }
    cost[fromx][fromy] = (aw, bw)
    if fromx == end.0, fromy == end.1 { break }
    for (ix, iy) in zip([0,0,1,-1], [1,-1,0,0]) {
        let (X, Y) = (fromx + ix, fromy + iy)
        guard (0..<N) ~= X, (0..<M) ~= Y else { continue }
        if X == end.0, Y == end.1 , compare((aw,bw), cost[X][Y]){
            heap.append((X, Y, aw, bw))
            continue
        }
        
        var isG = false
        for (ia, ib) in zip([0,0,1,-1], [1,-1,0,0]) where li[X][Y] == "." {
            let (A, B) = (X + ia, Y + ib)
            guard (0..<N) ~= A, (0..<M) ~= B else { continue }
            if li[A][B] == "g" { isG = true }
        }
        let (xw, yw) = (aw + (li[X][Y] == "g" ? 1 : 0), bw + (isG ? 1 : 0))
        if compare((xw, yw), cost[X][Y]) {
            cost[X][Y] = (xw, yw)
            heap.append((X, Y, xw, yw))
        }
    }
}
print(cost[end.0][end.1].0, cost[end.0][end.1].1)

/*
6 6
...g..
g.gFg.
......
......
gggggg
...S.g
 */
