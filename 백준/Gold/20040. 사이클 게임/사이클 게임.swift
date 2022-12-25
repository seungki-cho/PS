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
    let (a, b) = ([a, b].max()!, [a, b].min()!)
    let (aParent, bParent) = (find(a), find(b))
    if aParent != bParent {
        li[bParent] = aParent
    }
}

var fileIO = FileIO()
var (N, M) = (fileIO.readInt(), fileIO.readInt())
var answer = -1
var li = Array(repeating: -1, count: N+1)

(0..<M).forEach {
    let (a, b) = (fileIO.readInt(), fileIO.readInt())
    if answer != -1 { return }
       
    if find(a) == find(b), find(a) != -1 {
        answer = $0
        return
    }
    union(a, b)
}

print(answer+1)
