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
let l = {readLine()!.split{$0==" "}.map{Int($0)!}}
let N = Int(readLine()!)!
let M = Int(readLine()!)!
let heap = Heap<(Int, Int, String)>{ $0.1 < $1.1 }
var adj = Array(repeating: [(Int, Int)](), count: N)
(0..<M).forEach { _ in
    let abw = l()
    let (a, b, w) = (abw[0]-1, abw[1]-1, abw[2])
    adj[a].append((b, w))
}
let se = l()
let (start, end) = (se[0]-1, se[1]-1)
var cost = Array(repeating: Int.max, count: N)
heap.append((start, 0, "\(start)"))
var paths = Array(repeating: "", count: N)

while !heap.isEmpty {
    let (from, w, path) = heap.pop()
    if cost[from] < w { continue }
    cost[from] = w
    paths[from] = path
    if from == end { break }
    for (to, weight) in adj[from] where cost[to] > cost[from] + weight {
        heap.append((to, cost[from] + weight, path+" \(to)"))
    }
}
var ans = paths[end].split(separator: " ").map{String(Int($0)!+1)}
print(cost[end])
print(ans.count)
print(ans.joined(separator: " "))
