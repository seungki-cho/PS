import Foundation
let rc = readLine()!.split{$0==" "}.map{Int($0)!}
let (R, C) = (rc[0], rc[1])
let li = (0..<R).map { _ in readLine()!.map{String($0)} }
var isv = Array(repeating: Array(repeating: 0, count: C), count: R)
var q = [(0, 0)]
var isloop = false
var ans = 1
isv[0][0] = 1

while !q.isEmpty && !isloop {
    let (x, y) = q.removeLast()
    guard let s = Int(li[x][y]) else { continue }
    
    for (ix, iy) in zip([0,0,1,-1], [1,-1,0,0]) {
        let (X, Y) = (x + ix*s, y + iy*s)
        guard X >= 0 && Y >= 0 && X < R && Y < C,
              li[X][Y] != "H",
              isv[X][Y] < isv[x][y] + 1 else { continue }
        q.append((X, Y))
        isv[X][Y] = isv[x][y] + 1
        if isv[X][Y] >= 2501 { isloop = true }
        ans = max(isv[X][Y], ans)
    }
}

print(isloop ? -1 : ans)
