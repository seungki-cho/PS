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

let N = fio.readInt()
var li = Array(repeating: Array(repeating: 0, count: N), count: N)

(0..<N).forEach { i in
    (0..<N).forEach { j in
        li[i][j] = fio.readInt()
    }
}
var size = 2
var (ix, iy) = ([0, 0, 1, -1], [1, -1, 0, 0])

func findNear(_ X: Int, _ Y: Int) -> (Int, Int, Int)? {
    var q = [(Int, Int, Int)]()
    var isVisited = Array(repeating: Array(repeating: false, count: N), count: N)
    var answer = [Int: [(Int, Int)]]()
    q.append((X, Y, 0))
    isVisited[X][Y] = true
    
    while !q.isEmpty {
        let (x, y, length) = q.removeFirst()
        if answer[length-1] != nil {
            continue
        }

        for i in 0..<ix.count {
            let (thisX, thisY) = (x + ix[i], y + iy[i])
            if thisX < 0 || thisY < 0 || thisX >= N || thisY >= N {
                continue
            }
            
            if isVisited[thisX][thisY] {
                continue
            }
            
            if li[thisX][thisY] > size {
                isVisited[thisX][thisY] = true
                continue
            }
            
            
            if li[thisX][thisY] == 0 || li[thisX][thisY] == size {
                isVisited[thisX][thisY] = true
                q.append((thisX, thisY, length+1))
                continue
            }
            answer[length+1] = (answer[length+1] ?? []) + [(thisX, thisY)]
            isVisited[thisX][thisY] = true
        }
    }
    
    guard let min = answer.keys.min() else { return nil }
    if answer[min]!.count == 1 {
        return (answer[min]!.first!.0, answer[min]!.first!.1, min)
    }
    
    let hubo = answer[min]!.sorted { $0.1 < $1.1 }.sorted{ $0.0 < $1.0 }.first!
//    print(answer[min]!.sorted { $0.1 < $1.1 }.sorted{ $0.0 < $1.0 },min)
    return (hubo.0, hubo.1, min)
}

var (x, y) = (0, 0)
for i in 0..<N {
    for j in 0..<N {
        if li[i][j] == 9 {
            (x, y) = (i, j)
        }
    }
}

var time = 0
var eatCount = 0
while true {
    guard let (X, Y, length) = findNear(x, y) else { break }
    time += length
    eatCount += 1
    if eatCount == size {
        size += 1
        eatCount = 0
    }
    
    li[x][y] = 0
    li[X][Y] = 9
//    for i in 0..<N {
//        for j in 0..<N {
//            print(li[i][j],terminator: " ")
//        }
//        print()
//    }
//    print()
    (x,y) = (X, Y)
}
print(time)
