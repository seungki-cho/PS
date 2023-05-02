import Foundation

var ixiy = zip([0,0,1,-1], [1,-1,0,0])
var i = 0

while true {
    let N = Int(readLine()!)!
    if N == 0 { break }
    var li = [[Int]]()
    var v = Array(repeating: Array(repeating: Int.max, count: N), count: N)
    
    for _ in 0..<N {
        li.append(readLine()!.split(separator: " ").map{Int($0)!})
    }
    v[0][0] = li[0][0]
    var q = [(0, 0)]
    let can: (Int, Int) -> Bool = { $0 >= 0 && $1 >= 0 && $0 < N && $1 < N }
    
    while !q.isEmpty {
        let (x, y) = q.removeFirst()
        
        if x == N-1 && y == N-1 {
            continue
        }
        
        for (ix, iy) in ixiy {
            let (X, Y) = (x+ix, y+iy)
            if !can(X, Y) { continue }
            if v[X][Y] <= v[x][y] + li[X][Y] { continue }
    
            v[X][Y] = v[x][y] + li[X][Y]
            q.append((X, Y))
        }
    }
    print("Problem \(i+1):",v[N-1][N-1])
    i += 1
}
