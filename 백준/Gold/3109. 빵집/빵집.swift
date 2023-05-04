import Foundation
let rc = readLine()!.split(separator: " ").map{Int($0)!}
let (R, C) = (rc[0], rc[1])

var li = [[String]]()

for _ in 0..<R {
    li.append(readLine()!.map{String($0)})
}

var can: (Int, Int) -> Bool = {$0>=0 && $1>=0 && $0<R && $1<C}
var ans = 0
var ixiy = zip([-1,0,1], [1,1,1])

func dfs(_ x: Int, _ y: Int) -> Bool {
    if y == C-1 { return true }
    
    for (ix, iy) in ixiy {
        let (X, Y) = (x+ix, y+iy)
        if can(X, Y), li[X][Y] == ".", dfs(X, Y) {
            li[X][Y] = "\(ans)"
            return true
        }
    }
    li[x][y] = "@"
    return false
}

for i in 0..<R where dfs(i, 0){
    ans += 1
    li[i][0] = "\(ans)"
}

print(ans)
