import Foundation

let NM = readLine()!.split(separator: " ").map{Int($0)!}
let (N, M) = (NM[0], NM[1])
var li = [[Int]]()
for _ in 0..<N {
    li.append(readLine()!.split(separator: " ").map{Int($0)!})
}

func find() -> [(Int, Int)] {
    var q = [(0, 0)]
    var v = Array(repeating: Array(repeating: 0, count: M), count: N)
    v[0][0] = 1
    var ans = [(Int, Int)]()
    
    while !q.isEmpty {
        let (x, y) = q.removeLast()
        
        for (ix, iy) in zip([0,0,1,-1], [1,-1,0,0]) {
            let (X, Y) = (x+ix, y+iy)
            
            if X < 0 || Y < 0 || X >= N || Y >= M { continue }
            if li[X][Y] == 0 && v[X][Y] > 0 { continue }
            if li[X][Y] == 0 && v[X][Y] == 0 { q.append((X,Y)) }
            v[X][Y] += 1
            
            if li[X][Y] == 1 && v[X][Y] == 2 {
                ans.append((X, Y))
            }
        }
    }
    return ans
}

var count = 0
var ans = 0

while true {
    let removal = find()
    if removal.count == 0 { break }
    ans = removal.count
    
    for (x, y) in removal {
        li[x][y] = 0
    }
    
    
    count += 1
}
print(count)

