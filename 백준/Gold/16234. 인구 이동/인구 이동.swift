import Foundation
let (NLR) = readLine()!.split(separator: " ").map{Int(String($0))!}
let (N, L, R) = (NLR[0], NLR[1], NLR[2])
var li = [[Int]]()
for _ in 0..<N {
    li.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

var ans = 0
var (ix, iy) = ([0,0,1,-1], [1,-1,0,0])
while true {
    var flag = true
    
    var visited = Array(repeating: Array(repeating: false, count: N), count: N)
    
    func bfs(_ i: Int, _ j: Int) -> [(Int, Int)] {
        var ans = [(Int, Int)]()
        var q = [(i, j)]
        visited[i][j] = true
        while !q.isEmpty {
            let (x, y) = q.removeFirst()
            ans.append((x, y))
            for (nx, ny) in zip(ix, iy) {
                let (X, Y) = (x + nx, y + ny)
                if X < 0 || Y < 0 || X >= N || Y >= N { continue }
                if visited[X][Y] { continue }
                if abs(li[X][Y]-li[x][y]) < L || abs(li[X][Y]-li[x][y]) > R { continue }
                
                visited[X][Y] = true
                q.append((X, Y))
            }
        }
        return ans
    }
    
    var beChange = [[(Int,Int)]]()
    
    for i in 0..<N {
        for j in 0..<N where !visited[i][j] {
            beChange.append(bfs(i, j))
            if beChange.last!.count != 1 {
                flag = false
            }
        }
    }
    
    for change in beChange {
        let avg = change.reduce(0, { $0 + li[$1.0][$1.1] })/change.count
        change.forEach { li[$0.0][$0.1] = avg }
    }
    
    if flag {
        break;
    }
    ans += 1
}

print(ans)
