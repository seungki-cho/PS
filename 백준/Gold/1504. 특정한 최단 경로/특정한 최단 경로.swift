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

let NE = readLine()!.split(separator: " ").map { Int($0)! }
let (N, E) = (NE[0], NE[1])
var li = Array(repeating: [(Int,Int)](), count: N)
for _ in 0..<E {
    let abw = readLine()!.split(separator: " ").map{ Int($0)!}
    let (a, b, w) = (abw[0]-1, abw[1]-1, abw[2])
    li[a].append((b, w))
    li[b].append((a, w))
}
let a1a2 = readLine()!.split(separator: " ").map{ Int($0)! }
let (a1, a2) = (a1a2[0]-1, a1a2[1]-1)

var INF = 21_000_000_00

func dik(_ start: Int) -> [Int] {
    var distance = Array(repeating: INF, count: N)
    let q = Heap<(Int, Int)> { $0.1 < $1.1 }
    var v = Array(repeating: false, count: N)
    v[start] = true
    distance[start] = 0
    q.append((start, 0))
    
    while !q.li.isEmpty {
        let (curr, weight) = q.removeLast()!
        v[curr] = true
        
        for i in 0..<li[curr].count {
            let (next, nextWeight) = li[curr][i]
            if distance[next] > weight + nextWeight && !v[next]{
                distance[next] = weight + nextWeight
                q.append((next, distance[next]))
            }
        }
    }
    
    return distance
}
let from0 = dik(0)
let fromA1 = dik(a1)
let fromA2 = dik(a2)

let 웨이홍 = (from0[a1] + fromA1[a2] + fromA2[N-1])
let 껍떤씸 = (from0[a2] + fromA2[a1] + fromA1[N-1])


if 웨이홍 >= INF && 껍떤씸 >= INF {
    print(-1)
} else{
    print(min(웨이홍, 껍떤씸))
}

