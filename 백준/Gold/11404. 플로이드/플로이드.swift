import Foundation

let (N, M) = (Int(readLine()!)!, Int(readLine()!)!)
var li = Array(repeating: Array(repeating: 100_000*101, count: N), count: N)

for i in 0..<N {
    li[i][i] = 0
}

for _ in 0..<M {
    let abw = readLine()!.split(separator: " ").map{Int($0)!}
    let (a, b, w) = (abw[0]-1, abw[1]-1, abw[2])
    
    li[a][b] = min(li[a][b], w)
}

for k in 0..<N {
    for i in 0..<N {
        for j in 0..<N {
            li[i][j] = min(li[i][k] + li[k][j], li[i][j])
        }
    }
}

for i in 0..<N {
    for j in 0..<N {
        print(li[i][j] > 100_000*100 ? 0 : li[i][j], terminator: " ")
    }
    print()
}
