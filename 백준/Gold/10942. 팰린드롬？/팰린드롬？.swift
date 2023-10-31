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
let N = fio.readInt()
let li = (0..<N).map { _ in fio.readInt() }
var dp = Array(repeating: Array(repeating: false, count: N), count: N)
dp[0][0] = true
dp[N-1][N-1] = true
for i in 0..<N-1 {
    dp[i][i] = true
    dp[i][i+1] = li[i] == li[i+1]
}

for i in (0..<N).reversed() {
    for j in 0..<N where i < j-1 && li[i] == li[j] {
        dp[i][j] = dp[i+1][j-1]
    }
}
var ans = ""
(0..<fio.readInt()).forEach { _ in
    let (s, e) = (fio.readInt()-1, fio.readInt()-1)
    ans += "\((dp[s][e] ? 1 : 0))\n"
}
print(ans)
