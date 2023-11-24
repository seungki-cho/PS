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
var dp = Array(repeating: Array(repeating: 0, count: 2), count: N)
for _ in 0..<N-1 {
    let (u, v) = (f.r()-1, f.r()-1)
    adj[u].append(v)
    adj[v].append(u)
}

var isv = Array(repeating: false, count: N)

func dfs(_ n: Int){
    
    dp[n][1] = 1
    for to in adj[n] where !isv[to] {
        isv[to] = true
        dfs(to)
        dp[n][1] += min(dp[to][1], dp[to][0])
        dp[n][0] += dp[to][1]
    }
}
isv[0] = true
dfs(0)

print(min(dp[0][0], dp[0][1]))
