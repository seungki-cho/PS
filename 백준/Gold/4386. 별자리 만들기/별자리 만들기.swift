import Foundation
let n = Int(readLine()!)!
var stars = [(Double, Double)]()

for _ in 0..<n {
    var xy = readLine()!.split(separator: " ").map { Double($0)! }
    stars.append((xy[0], xy[1]))
}

var abw = [(Int, Int, Double)]()


func getdis(_ xy: (Double, Double), _ ab: (Double, Double)) -> Double {
    let (x, y, a, b) = (xy.0, xy.1, ab.0, ab.1)
    
    return sqrt((x - a)*(x - a) + (y - b)*(y - b))
}

for i in 0..<n {
    for j in i+1..<n {
        abw.append((i, j, getdis(stars[i], stars[j])))
    }
}

var uf = Array(repeating: -1, count: n)
func find(_ n: Int) -> Int {
    if uf[n] < 0 {
        return n
    }
    uf[n] = find(uf[n])
    return uf[n]
}

func union(_ a: Int, _ b: Int) {
    let (A, B) = (find(a), find(b))
    if A != B {
        uf[B] = A
    }
}
var ans = 0.0

abw.sorted { $0.2 < $1.2 }.forEach { a, b, w in
    if find(a) != find(b) {
        union(a, b)
        ans += round(w * 100)/100
    }
}
print(ans)
