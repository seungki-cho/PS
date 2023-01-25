import Foundation

struct Queue<T> {
    var enq = [T]()
    var pointer = -1
    var counter = 0
    
    var isEmpty: Bool {
        counter == 0
    }
    
    mutating func append(_ element: T) {
        enq.append(element)
        counter += 1
    }
    mutating func popFirst() -> T {
        pointer += 1
        counter -= 1
        return enq[pointer]
    }
}

enum Direction {
    case horizontal
    case vertical
    case diagonal
}

let N = Int(readLine()!)!
var arr = [[Int]]()
var q = Queue<(Direction, Int, Int)>()
var answer = 0

for _ in 0..<N {
    arr.append(readLine()!.split(separator: " ").map{Int($0)!})
}

func myfunc(_ dir: Direction, _ x: Int, _ y: Int){
    if x == N-1 && y == N-1 {
        answer += 1
        return
    }
    
    var hubo = [(Direction, Int, Int)]()
    switch dir {
        case .horizontal:
            hubo = [(Direction.horizontal, x, y+1), (Direction.diagonal, x+1, y+1)]
        case .vertical:
            hubo = [(Direction.vertical, x+1, y), (Direction.diagonal, x+1, y+1)]
        case .diagonal:
            hubo = [(Direction.horizontal, x, y+1), (Direction.vertical, x+1, y), (Direction.diagonal, x+1, y+1)]
    }
    for (dire, X, Y) in hubo {
        if X >= N || Y >= N {
            continue
        }

        switch dire {
            case .horizontal, .vertical:
                if !(arr[X][Y] == 0) {
                    continue
                }
            case .diagonal:
                if !(arr[X][Y] == 0 && arr[X-1][Y] == 0 && arr[X][Y-1] == 0) {
                    continue
                }
        }
        myfunc(dire, X, Y)
    }
}

myfunc(Direction.horizontal, 0, 1)
//
//while !q.isEmpty {
//    let (dir, x, y) = q.popFirst()
//    if x == N-1 && y == N-1 {
//        answer += 1
//        continue
//    }
//    var hubo = [(Direction, Int, Int)]()
//
//    switch dir {
//        case .horizontal:
//            hubo += [(Direction.horizontal, x, y+1), (Direction.diagonal, x+1, y+1)]
//        case .vertical:
//            hubo += [(Direction.vertical, x+1, y), (Direction.diagonal, x+1, y+1)]
//        case .diagonal:
//            hubo += [(Direction.horizontal, x, y+1), (Direction.vertical, x+1, y), (Direction.diagonal, x+1, y+1)]
//    }
//    for (dire, X, Y) in hubo {
//        if X < 0 || Y < 0 || X >= N || Y >= N {
//            continue
//        }
//
//        switch dire {
//            case .horizontal, .vertical:
//                if !(arr[X][Y] == 0) {
//                    continue
//                }
//            case .diagonal:
//                if !(arr[X][Y] == 0 && arr[X-1][Y] == 0 && arr[X][Y-1] == 0) {
//                    continue
//                }
//        }
//        q.append((dire, X, Y))
//    }
//}
print(answer)
