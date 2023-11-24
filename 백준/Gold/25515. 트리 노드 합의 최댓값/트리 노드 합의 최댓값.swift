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
let N = f.r()
var adj = Array(repeating: [Int](), count: N)
(0..<N-1).forEach { _ in
    let (a,b)=(f.r(),f.r())
    adj[a].append(b)
    adj[b].append(a)
}
var w = (0..<N).map{_ in f.r() }
var ans = Array(repeating: 0, count: N)
var isv = Array(repeating: false, count: N)

func dfs(_ n: Int) {
    ans[n] = w[n]
    for to in adj[n] where !isv[to] {
        isv[to] = true
        dfs(to)
        ans[n] = max(ans[n], ans[n] + ans[to])
    }
}

isv[0] = true
dfs(0)
print(ans[0])
