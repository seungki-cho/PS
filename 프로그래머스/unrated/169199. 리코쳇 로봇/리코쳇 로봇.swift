import Foundation

func solution(_ board:[String]) -> Int {
    let li = board.map { $0.map {String($0) }}
    var isVisited = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
    
    func isIn(_ x: Int, _ y: Int) -> Bool {
        x < li.count && x >= 0 && y < li[0].count && y >= 0
    }
    
    func left(_ x: Int, _ y: Int) -> (Int, Int) {
        for i in 0..<li[0].count where isIn(x, y-i) {
            if li[x][y-i] == "D" {
                return (x, y-i+1)
            }
        }
        return (x, 0)
    }
    func up(_ x: Int, _ y: Int) -> (Int, Int) {
        for i in 0..<li.count where isIn(x-i, y) {
            if li[x-i][y] == "D" {
                return (x-i+1, y)
            }
        }
        return (0, y)
    }
    func right(_ x: Int, _ y: Int) -> (Int, Int) {
        for i in 0..<li[0].count where isIn(x, y+i) {
            if li[x][y+i] == "D" {
                return (x, y+i-1)
            }
        }
        return (x, li[0].count-1)
    }
    func down(_ x: Int, _ y: Int) -> (Int, Int) {
        for i in 0..<li.count where isIn(x+i, y) {
            if li[x+i][y] == "D" {
                return (x+i-1, y)
            }
        }
        return (li.count-1, y)
    }
    
    var q = [(Int, Int, Int)]()
    
    for i in 0..<li.count {
        for j in 0..<li[0].count {
            if li[i][j] == "R" {
                q.append((i, j, 0))
                isVisited[i][j] = true
            }
        }
    }
    while !q.isEmpty {
        let (x, y, c) = q.removeFirst()
        if li[x][y] == "G" { return c }
        
        isVisited[x][y] = true
        
        let (lX, lY) = left(x, y)
        let (rX, rY) = right(x, y)
        let (uX, uY) = up(x, y)
        let (dX, dY) = down(x, y)
        
        if !isVisited[lX][lY] { q.append((lX, lY, c+1))}
        if !isVisited[rX][rY] { q.append((rX, rY, c+1))}
        if !isVisited[uX][uY] { q.append((uX, uY, c+1))}
        if !isVisited[dX][dY] { q.append((dX, dY, c+1))}
    }
    
    
    
    return -1
}