import Foundation

let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".map { String($0) }
var dick = [String: Int]()
for i in 0..<alphabet.count {
    dick[alphabet[i]] = i + 1
}

let RC = readLine()!.split(separator: " ").map{Int($0)!}
let (R, C) = (RC[0], RC[1])
var li = [[Int]]()
var ans = 0

var alphaSet = Set<String>()
for _ in 0..<R {
    li.append(readLine()!.map{dick[String($0)]!})
}


let (ix, iy) = ([0,0,1,-1], [1,-1,0,0])

func dfs(_ x: Int, _ y: Int, _ n: Int, _ bit: Int) {
    ans = max(n, ans)
    for (ix, iy) in zip(ix, iy) {
        let (X, Y) = (x+ix, y+iy)
        if X < 0 || Y < 0 || X >= R || Y >= C { continue }
        
        let nextAlpha = 1 << li[X][Y]
        if bit & nextAlpha == 0 {
            dfs(X, Y, n+1, bit | nextAlpha)
        }
    }
}


dfs(0, 0, 1, 1 << li[0][0])
print(ans)
