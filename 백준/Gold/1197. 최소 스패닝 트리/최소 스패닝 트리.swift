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

func find(_ n: Int) -> Int {
    if li[n] == -1 {
        return n
    }
    li[n] = find(li[n])
    return li[n]
}

func union(_ a: Int, _ b: Int) {
    var (a, b) = ([a, b].min()!, [a, b].max()!)
    (a, b) = (find(a), find(b))
    if a != b {
        li[b] = a
    }
}

var fio = FileIO()
var (V, E) = (fio.readInt(), fio.readInt())
var li = Array(repeating: -1, count: V+1)
var edges = [(Int, Int, Int)]()
var (count, answer) = (0, 0)

(0..<E).forEach { _ in
    edges.append((fio.readInt(), fio.readInt(), fio.readInt()))
}

edges.sorted { $0.2 < $1.2 }
    .forEach { (a, b, c) in
        if count == V-1 { return }
        
        if find(a) != find(b) || find(a) + find(b) == -2 {
            union(a, b)
            answer += c
            count += 1
        }
}

print(answer)
