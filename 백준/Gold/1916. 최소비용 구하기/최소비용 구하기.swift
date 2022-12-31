import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

var fio = FileIO()

let (N, M) = (fio.readInt(), fio.readInt())
var costs = Array(repeating: Array(repeating: Int.max, count: N), count: N)
(0..<N).forEach {
    costs[$0][$0] = 0
}

(0..<M).forEach { _ in
   let (from, to, cost) = (fio.readInt() - 1, fio.readInt() - 1, fio.readInt())
    
    if cost < costs[from][to] {
        costs[from][to] = cost
    }
}
let (from, to) = (fio.readInt()-1, fio.readInt()-1)

var pq = [Int]()
var distance = Array(repeating: Int.max, count: N)
var visited = Array(repeating: false, count: N)

distance[from] = 0
visited[from] = true
pq.append(from)

while let current = pq.first {
    pq.removeFirst()
    visited[current] = true
    
    for i in 0..<N {
        if costs[current][i] == Int.max {
            continue
        }
        
        if (distance[current] + costs[current][i]) < distance[i] {
            distance[i] = distance[current] + costs[current][i]
            pq.append(i)
        }
    }
}
print(distance[to])
