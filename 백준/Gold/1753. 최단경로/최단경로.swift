import Foundation

class Heap<T> {
    var compare: (T, T) -> Bool
    var li = [T]()

    init(_ compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }

    func p(_ n: Int) -> Int { (n-1)/2 }
    func l(_ n: Int) -> Int { n*2+1 }
    func r(_ n: Int) -> Int { (n+1)*2 }

    func append(_ elem: T) {
        li.append(elem)
        var point = li.count-1

        while point > 0 {
            if compare(li[point], li[p(point)]) {
                li.swapAt(p(point), point)
                point = p(point)
            } else {
                break;
            }
        }
    }

    func removeLast() -> T? {
        if li.count == 0 { return nil }
        li.swapAt(0, li.count-1)
        let ret = li.removeLast()

        var point = 0

        while r(point) <= li.count-1 { // 둘다 존재
            let (L, R, me) = (li[l(point)], li[r(point)], li[point])

            if compare(L, R) {
                if compare(L, me) {
                    li.swapAt(l(point), point)
                    point = l(point)
                } else {
                    break;
                }
            } else {
                if compare(R, me) {
                    li.swapAt(r(point), point)
                    point = r(point)
                } else {
                    break;
                }
            }
        }

        if l(point) == li.count - 1 {
            if compare(li[l(point)], li[point]) {
                li.swapAt(l(point), point)
            }
        }

        return ret
    }
}


var heap = Heap<(Int, Int)>{ $0.1 < $1.1 }

let VE = readLine()!.split(separator: " ").map{ Int($0)! }
let start = Int(readLine()!)!-1

var lii = Array(repeating: [(Int, Int)](), count: VE[0])

for _ in 0..<VE[1] {
    let abw = readLine()!.split(separator: " ").map{ Int($0)! }
    let (a, b, w) = (abw[0]-1, abw[1]-1, abw[2])
    lii[a].append((b,w))
}

heap.append((start, 0))

var visited = Array(repeating: false, count: VE[0])
visited[start] = true

var INF = 9_9_9_9_9_9_9

var distance = Array(repeating: INF, count: VE[0])
distance[start] = 0

while heap.li.count != 0 {
    let (next, weight) = heap.removeLast()!
    visited[next] = true
    for i in 0..<lii[next].count where !visited[lii[next][i].0] {
        let (curr, currWeight) = lii[next][i]
        if distance[curr] > currWeight + weight {
            distance[curr] = currWeight + weight
            heap.append((curr, distance[curr]))
        }
    }
}
print(distance.map { $0 >= INF ? "INF\n" : "\($0)\n"}.joined())
