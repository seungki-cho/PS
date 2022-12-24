import Foundation

final class FileIO {
    private let buffer: Data
    private var index: Int = 0
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        self.buffer = try! fileHandle.readToEnd()! // 인덱스 범위 넘어가는 것 방지
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer {
            index += 1
        }
        guard index < buffer.count else { return 0 }
        
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
        var str = ""
        var now = read()
        
        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        
        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }
        
        return str
    }
}

let fileIO = FileIO()
let n = fileIO.readInt()
var xy = [(Int,Int)]()

for _ in 0..<n {
    let x = fileIO.readInt()
    let y = fileIO.readInt()
    xy.append((x, y))
}

let xFirst = xy.sorted { $0.0 < $1.0 }

var remove = [Int]()

var tthis: (Int, Int)?

var these = [(Int,Int)]()
for i in 0..<xFirst.count {
    if let this = tthis {
        if this.0...this.1 ~= xFirst[i].0 {
            if xFirst[i].1 > this.1 {
                tthis = (this.0, xFirst[i].1)
            }
            continue
        } else {
            these.append(this)
            tthis = xFirst[i]
        }
    } else {
        tthis = xFirst[i]
    }
}

if let this = tthis {
    these.append(this)
}
print(these.reduce(0) { $0 + ($1.1 - $1.0) })

