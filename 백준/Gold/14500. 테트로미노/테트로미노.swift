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
var arr = Array(repeating: Array(repeating: 0, count: M), count: N)
var vv = Array(repeating: Array(repeating: false, count: M), count: N)
(0..<N).forEach { i in
    (0..<M).forEach { j in
        arr[i][j] = fio.readInt()
    }
}
var maxx = 0
var (xx, yy) = ([1,-1,0,0],[0,0,1,-1])
func dfs(_ i: Int, _ j: Int, _ c: Int, _ n: Int) {
    if c == 4{
        maxx = max(n, maxx)
        return
    }
    for a in 0..<xx.count {
        let X = i + xx[a]
        let Y = j + yy[a]
        
        if X < 0 || Y < 0 || X>=N || Y>=M{
            continue
        }
        if vv[X][Y]{
            continue
        }
        
        vv[X][Y].toggle()
        dfs(X, Y, c+1, n+arr[X][Y])
        vv[X][Y].toggle()
    }
}

(0..<N).forEach { i in
    (0..<M).forEach { j in
        vv[i][j] = true
        dfs(i, j, 1, arr[i][j])
        vv[i][j] = false
        
        if i < N - 2 && j < M - 1{
            maxx = max(maxx, arr[i][j] + arr[i+1][j] + arr[i+1][j+1] + arr[i+2][j])
        }
        if i < N - 1 && j < M - 2{
            maxx = max(maxx, arr[i][j] + arr[i][j+1] + arr[i][j+2] + arr[i+1][j+1])
        }
        if i >= 1 && j < M - 2{
            maxx = max(maxx, arr[i][j] + arr[i-1][j+1] + arr[i][j+1] + arr[i][j+2])
        }
        if 1 <= i && (i < (N - 1)) && j < M - 1{
            maxx = max(maxx, arr[i][j] + arr[i-1][j+1] + arr[i][j+1] + arr[i+1][j+1])
        }
    }
}
print(maxx)
