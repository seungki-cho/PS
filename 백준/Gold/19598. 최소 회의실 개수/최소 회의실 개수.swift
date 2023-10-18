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
    var top: T {
        heap.first!
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

let n = Int(readLine()!)!
var abs = [(Int, Int)]()
(0..<n).forEach { _ in
    let ab = readLine()!.split{$0==" "}.map{Int($0)!}
    abs.append((ab[0], ab[1]))
}
if n == 1 { print(1); exit(0)}
abs.sort{$0.0 < $1.0}

let heap = Heap<Int>() { $0 < $1 }
heap.append(abs[0].1)

for i in 1..<n {
    let (start, end) = abs[i]
    if heap.top <= start {
        heap.pop()
    }
    heap.append(end)
}

print(heap.heap.count)
