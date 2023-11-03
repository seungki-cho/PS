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
let (n, m) = (nm[0], nm[1])
var adj = Array(repeating: [(Int, Int)](), count: n)
for _ in 0..<m {
    let abc = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a, b, c) = (abc[0]-1, abc[1]-1, abc[2])
    adj[a].append((b, c))
    adj[b].append((a, c))
}
let se = readLine()!.split{$0==" "}.map{Int($0)!}
let (s, e) = (se[0]-1, se[1]-1)
var isv = Array(repeating: false, count: n)
isv[s] = true
let heap = Heap<(Int, Int)> { $0.1 > $1.1 }
heap.append((s, Int.max))
var ans = Int.max
for i in 0..<n { adj[i].sort(by: {$0.1 > $1.1}) }
var dik = Array(repeating: 0, count: n)

while !heap.isEmpty {
    let (from, weight) = heap.pop()
    if weight < dik[from] { continue }
    adj[from].forEach { to, toWeight in
        if dik[to] < min(toWeight, weight) {
            heap.append((to, min(toWeight, weight)))
            dik[to] = min(toWeight, weight)
        }
    }
}
print(dik[e])
