import Foundation

let nm = readLine()!.split(separator: " ").map{Int($0)!}
let (n, m) = (nm[0], nm[1])
var uf = Array(repeating: -1, count: n)

func find(_ n: Int) -> Int {
    if uf[n] == -1 {
        return n
    }
    uf[n] = find(uf[n])
    return uf[n]
}

func merge(_ a: Int, _ b: Int) {
    let (a, b) = (find(a), find(b))
    if a != b {
        uf[b] = a
    }
}

var hubo = [(Int, Int, Int)]()
for _ in 0..<m { // m
    let abw = readLine()!.split(separator: " ").map{Int($0)!}
    let (a, b, w) = (abw[0]-1, abw[1]-1, abw[2])
    hubo.append((a, w, b))
}

var weights = [Int]()
for (from, weight, to) in hubo.sorted { $0.1 < $1.1 } where weights.count + 2 != n { // m
    if find(from) != find(to) {
        merge(from, to) // log n
        weights.append(weight) // 1
    }
}
print(weights.reduce(0, +)) // n
