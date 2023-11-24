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

    @inline(__always) func r() -> Int {
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
}
let f = FileIO()
let (N, M) = (f.r(), f.r())
var adj = Array(repeating: [Int](), count: N)
_=f.r()
for i in 1..<N {
    adj[f.r()-1].append(i)
}
var ans = Array(repeating: 0, count: N)
for i in 0..<M {
    let to = f.r()-1
    let w = f.r()
    ans[to] += w
}
for i in 0..<N {
    adj[i].forEach { ans[$0] += ans[i] }
}

for i in 0..<N {
    print(ans[i],terminator: " ")
}
