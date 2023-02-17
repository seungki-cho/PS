import Foundation

var map = [[String]]()

struct 큐 {
    var q = [(Int, Int)]()
    var idx = -1
    var count = 0
    
    var isEmpty: Bool { count == 0 }
    
    mutating func append(_ element: (Int, Int)) {
        q.append(element)
        count += 1
    }
    mutating func removeFirst() -> (Int, Int) {
        idx += 1
        count -= 1
        return q[idx]
    }
}

func bfs(_ startX:Int, _ startY:Int, _ endX: Int, _ endY: Int) -> Int {
    var q = 큐()
    var visited = Array(repeating: Array(repeating: false, count: map[0].count), count: map.count)
    
    q.append((startX, startY))
    visited[startX][startY] = true
    var distance = 1
    
    while !q.isEmpty {
        for _ in 0..<q.count {
            let (x, y) = q.removeFirst()
            for (ix, iy) in [(0, 1), (0, -1), (1, 0), (-1, 0)] {
                let (X, Y) = (x + ix, y + iy)
                if X == endX && Y == endY { return distance }
                if X < 0 || Y < 0 || X >= map.count || Y >= map[0].count { continue }
                if visited[X][Y] || map[X][Y] == "X"  { continue }
                visited[X][Y] = true
                q.append((X, Y))
            }
        }
        distance += 1
    }
    return -1
}

func solution(_ maps:[String]) -> Int {
    map = maps.map{Array($0).map{String($0)}}
    var (SX, SY, LX, LY, EX, EY) = (0, 0, 0, 0, 0, 0)
    
    for i in 0..<map.count {
        for j in 0..<map[0].count {
            if map[i][j] == "S" { (SX, SY) = (i, j)}
            if map[i][j] == "L" { (LX, LY) = (i, j)}
            if map[i][j] == "E" { (EX, EY) = (i, j)}
        }
    }

    let StoL = bfs(SX, SY, LX, LY)
    if StoL == -1 { return -1 }
    
    let LtoE = bfs(LX, LY, EX, EY)
    if LtoE == -1 { return -1 }
    
    return StoL + LtoE
}

//print(solution(["XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXSOOOLXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXOXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXOOOOOXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXOXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXOOOOEXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"]))
