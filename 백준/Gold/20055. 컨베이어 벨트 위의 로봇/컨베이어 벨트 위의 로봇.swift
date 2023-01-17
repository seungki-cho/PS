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

let (N, K) = (fio.readInt(), fio.readInt())
var belt = Array(repeating: (0, 0), count: 2*N)
(0..<2*N).forEach {
    belt[$0].0 = fio.readInt()
}
var (up, ans) = (0, 0)
while true {
    ans += 1
    //1. 벨트가 각 칸 위에 있는 로봇과 함께 한 칸 회전한다.
    up = (up == 0 ? 2*N-1 : up-1)
    let down = (up + (N-1)) % (2*N)
    belt[down].1 = 0
    
    //2. 가장 먼저 벨트에 올라간 로봇부터, 벨트가 회전하는 방향으로 한 칸 이동할 수 있다면 이동한다. 만약 이동할 수 없다면 가만히 있는다.
    // 로봇이 이동하기 위해서는 이동하려는 칸에 로봇이 없으며, 그 칸의 내구도가 1 이상 남아 있어야 한다.
    (0..<N).forEach { i in
        let this = (up + N - i) % (2*N)
        let next = (this + 1) % (2*N)
        
        if belt[next].0 > 0 && belt[next].1 == 0 && belt[this].1 > 0 {
            belt[next].0 -= 1
            belt[next].1 += 1
            belt[this].1 -= 1
        }
    }
    belt[down].1 = 0
    
    //3. 올리는 위치에 있는 칸의 내구도가 0이 아니면 올리는 위치에 로봇을 올린다.
    if belt[up].0 > 0{
        belt[up].1 += 1
        belt[up].0 -= 1
    }
    if belt.filter({ $0.0 == 0 }).count >= K {
        break
    }
}
print(ans)
