import Foundation

var NM = readLine()!.split(separator: " ").map{ Int($0)! }
var (N, M) = (NM[0], NM[1])
var li = [[Int]]()

for _ in 0..<N {
    li.append(readLine()!.split(separator: " ").map{Int($0)!})
}

var visited = Array(repeating: Array(repeating: false, count: M), count: N)
var (ix, iy) = ([0,0,1,-1], [1,-1,0,0])

var ans = 0

func bfs(_ i: Int, _ j: Int) {
    var q = [(i, j)]
    
    visited[i][j] = true
    var removal = Array(repeating: Array(repeating: 0, count: M), count: N)
    var i = 0
    while !q.isEmpty {
        let (x, y) = q.removeLast()
        var removeCount = 0
        
        for (nx, ny) in zip(ix, iy) {
            let (X, Y) = (x + nx, y + ny)
            
            if X < 0 || Y < 0 || X >= N || Y >= M { continue }
            if li[X][Y] == 0 { removeCount += 1; continue }
            if visited[X][Y] { continue }
            visited[X][Y] = true
            q.append((X, Y))
        }
        removal[x][y] += removeCount
        i += 1
    }
    
    for i in 0..<N {
        for j in 0..<M {
            li[i][j] = (li[i][j] - removal[i][j]) < 0 ? 0 : (li[i][j] - removal[i][j])
        }
    }
}

while true {
    ans += 1
    var 처음으로땅을밟았습니까 = true
    visited = Array(repeating: Array(repeating: false, count: M), count: N)
    var fflag = false
    
    for i in 0..<N where !fflag {
        for j in 0..<M where li[i][j] != 0 && !visited[i][j] && !fflag {
            if 처음으로땅을밟았습니까 {
                처음으로땅을밟았습니까 = false
                bfs(i, j)
            } else {
                fflag = true
                
            }
        }
    }

    if 처음으로땅을밟았습니까 {
        ans = 1
        break;
    }
    if fflag { break; }
}
print(ans-1)

