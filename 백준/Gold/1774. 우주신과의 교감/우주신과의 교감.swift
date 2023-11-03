import Foundation

let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let (n, m) = (nm[0], nm[1])
var uf = Array(repeating: -1, count: n)
func find(_ n: Int) -> Int {
    if uf[n] < 0 {
        return n
    }
    uf[n] = find(uf[n])
    return uf[n]
}
func merge(_ x: Int, _ y: Int) {
    let (x, y) = (find(x), find(y))
    if x != y {
        uf[x] = y
    }
}
let sins = (0..<n).map { _ -> (Double, Double) in
    let abc = readLine()!.split{$0==" "}.map{Double($0)!}
    return (abc[0], abc[1])
}
var edges = [(Int, Int, Double)]()

for i in 0..<n {
    for j in 0..<n where j > i {
        let (ax, ay): (Double, Double) = sins[i]
        let (bx, by): (Double, Double) = sins[j]
        edges.append((i, j, sqrt(pow((ax - bx), 2.0) + pow((ay - by), 2.0))))
    }
}

for _ in 0..<m {
    let abc = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a, b) = (abc[0]-1, abc[1]-1)
    merge(a, b)
}
edges.sort { $0.2 < $1.2 }
var ans = 0.0
for (a, b, w) in edges where find(a) != find(b) {
    merge(a, b)
    ans += w
}

print(String(format: "%.02f", round(ans*100)/100))
