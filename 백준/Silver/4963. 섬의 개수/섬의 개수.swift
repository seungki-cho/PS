import Foundation
while true {
    let WH = readLine()!.split(separator: " ").map{Int($0)!}
    let (h, w) = (WH[0], WH[1])
    if w | h == 0 { break; }
    var li = [[Int]]()
    for i in 0..<w {
        li.append(readLine()!.split(separator: " ").map{Int($0)!})
    }
    
    var v = Array(repeating: Array(repeating: false, count: h), count: w)
    
    let (ix, iy) = ([-1,-1,-1,1,1,1,0,0], [-1,0,1,-1,0,1,1,-1])
    var ans = 0
    
    func bfs(_ i: Int, _ j: Int) {
        for A in 0..<ix.count {
            let (x,y) = (i+ix[A], j+iy[A])
            if x < 0 || y < 0 || x >= w || y >= h { continue }
            if v[x][y] || li[x][y] == 0 { continue }
            v[x][y] = true
            bfs(x, y)
        }
    }
    
    for i in 0..<w {
        for j in 0..<h where !v[i][j] && li[i][j] == 1 {
            v[i][j] = true
            bfs(i, j)
            ans += 1
        }
    }
//    for i in 0..<w{
//        for j in 0..<h{
//            print(v[i][j], terminator: " ")
//        }
//        print()
//    }
    print(ans)
}
