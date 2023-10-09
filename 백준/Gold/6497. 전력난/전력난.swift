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
let fio = FileIO()
while true {
    let (m, n) = (fio.readInt(), fio.readInt())
    if n | m == 0 { break }
    var edges = (0..<n).map{ _ -> (Int, Int, Int) in
        return (fio.readInt(), fio.readInt(), fio.readInt())
    }
    edges.sort{ $0.2 < $1.2 }
    var (dp, ans) = (Array(repeating: -1, count: m), 0)
    func find(_ a: Int)->Int{
        if dp[a] == -1 { return a }
        dp[a]=find(dp[a])
        return dp[a]
    }
    func me(_ a: Int, _ b: Int) {
        let (a, b) = (find(a), find(b))
        dp[a] = a != b ? b : dp[a]
    }
    var count = 0
    edges.forEach{ (a, b, w) in if count != m-1 && find(a) != find(b) { ans += w; me(a, b); count += 1} }
    print(edges.reduce(0){$0+$1.2}-ans)
}
