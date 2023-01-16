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

enum di: Int {
    case u, r, d, l
    
    func lef() -> (Int, Int) {
        switch self {
            case .u:
                return (0, -1)
            case .r:
                return (-1, 0)
            case .d:
                return (0, 1)
            case .l:
                return (1, 0)
        }
    }
    
    func bac() -> (Int, Int) {
        switch self {
            case .u:
                return (1, 0)
            case .r:
                return (0, -1)
            case .d:
                return (-1, 0)
            case .l:
                return (0, 1)
        }
    }
}

let (N, M) = (fio.readInt(), fio.readInt())
var (r, c, d) = (fio.readInt(), fio.readInt(), di(rawValue: fio.readInt())!)
var arr = Array(repeating: Array(repeating: 0, count: M), count: N)

for i in 0..<N {
    for j in 0..<M {
        arr[i][j] = fio.readInt()
    }
}

var ans = 0

func clean(_ x: Int, _ y: Int) {
    if arr[x][y] == 0 {
        ans += 1
        arr[x][y] = 2
    }
//    for i in 0..<N {
//        for j in 0..<M {
//            if i == r && j == c {
//                print(d, terminator: " ")
//            }else{
//                print(arr[i][j], terminator: " ")
//            }
//        }
//        print()
//    }
//    print()

}
func isIn(_ x: Int, _ y: Int, _ plus: (Int, Int)) -> Bool {
    let (X, Y) = (x+plus.0, y+plus.1)
    if X<0 || Y<0 || X>=N || Y>=M {
        return false
    }
    return true
}
func isCleanable(_ x: Int, _ y: Int, _ plus: (Int, Int)) -> Bool {
    let (X, Y) = (x+plus.0, y+plus.1)
    if arr[X][Y] == 0 {
        return true
    }
    return false
}
func isMoveable(_ x: Int, _ y: Int, _ plus: (Int, Int)) -> Bool {
    let (X, Y) = (x+plus.0, y+plus.1)
    if arr[X][Y] == 1 {
        return false
    }
    return true
}
func move(_ p: (Int, Int)){
    r+=p.0
    c+=p.1
}
func turnLeft(){
    d = .init(rawValue: (d.rawValue + 3) % 4)!
}
while true {
    clean(r, c)
    
    if isIn(r, c, d.lef()),
       isCleanable(r, c, d.lef()) {
        move(d.lef())
        turnLeft()
        continue
    } else {
        turnLeft()
    }
    if isIn(r, c, d.lef()),
       isCleanable(r, c, d.lef()) {
        move(d.lef())
        turnLeft()
        continue
    } else {
        turnLeft()
    }
    if isIn(r, c, d.lef()),
       isCleanable(r, c, d.lef()) {
        move(d.lef())
        turnLeft()
        continue
    } else {
        turnLeft()
    }
    if isIn(r, c, d.lef()),
       isCleanable(r, c, d.lef()) {
        move(d.lef())
        turnLeft()
        continue
    } else {
        turnLeft()
    }
    
    if isIn(r, c, d.bac()),
       isMoveable(r, c, d.bac()) {
        move(d.bac())
        continue
    }
    break
}
print(ans)
