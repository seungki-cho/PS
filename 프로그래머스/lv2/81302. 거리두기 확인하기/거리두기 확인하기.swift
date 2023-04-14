import Foundation

func solution(_ places:[[String]]) -> [Int] {
    let (ix, iy) = ([0,0,1,-1], [1,-1,0,0])
    var ans = [Int]()
    for place in places {
        let li = place.map{Array($0)}
        var flag = false
        var v = Array(repeating: Array(repeating: false, count: 5), count: 5)
        
        func dfs(_ i: Int, _ j: Int, _ n: Int) {
            if flag || n == 2 {
                return
            }
            for (x, y) in zip(ix, iy) {
                let (X, Y) = (i+x, j+y)
                if X < 0 || Y < 0 || X >= 5 || Y >= 5 { continue }
                if v[X][Y] { continue }
                if li[X][Y] == "X" { continue }
                if li[X][Y] == "P" { flag = true; return }
                
                v[X][Y] = true
                dfs(X, Y, n+1)
                v[X][Y] = false
            }
        }
        
        for i in 0..<5{
            for j in 0..<5 where li[i][j] == "P"{
                v[i][j] = true
                dfs(i, j, 0)
                v[i][j] = false
            }
        }
        ans.append(flag ? 0 : 1)
        
    }
    return ans
}