import Foundation

func solution(_ maps:[String]) -> [Int] {
    let map = maps.map{ $0.map{String($0)}.map{ $0 == "X" ? 0 : Int($0)!} }
    var visited = Array(repeating: Array(repeating: false, count: map[0].count), count: map.count)
    
    func bfs(_ sx: Int, _ sy: Int) -> Int {
        var (q, ret) = ([(sx, sy)], 0)
        while !q.isEmpty {
            let (x, y) = q.removeFirst()
            ret += map[x][y]
            for (ix, iy) in [(0,-1), (0,1), (1,0), (-1, 0)] {
                let (X, Y) = (ix + x, iy + y)
                if X < 0 || Y < 0 || X >= map.count || Y >= map[0].count { continue }
                if visited[X][Y] || map[X][Y] == 0 { continue }
                visited[X][Y] = true
                q.append((X, Y))
            }
        }
        return ret
    }
    
    var answer = [Int]()
    
    for i in 0..<map.count {
        for j in 0..<map[0].count {
            if map[i][j] != 0 && !visited[i][j] {
                visited[i][j] = true
                answer.append(bfs(i, j))
            }
        }
    }
   
    return answer.count == 0 ? [-1] : answer.sorted(by: <)
}
