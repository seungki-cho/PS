import Foundation
let (R, C) = (12, 6)
var li = [[String]]()

for _ in 0..<R {
    li.append(readLine()!.map{String($0)})
}

var v = Array(repeating: Array(repeating: false, count: C), count: R)
let ixiy = zip([0,0,1,-1],[1,-1,0,0])
func boom(_ i: Int, _ j: Int) -> [(Int, Int)]{
    var q = [(i, j)]
    var ans = q
    var color = li[i][j]
    v[i][j] = true
    while !q.isEmpty {
        let (x, y) = q.removeFirst()
        
        for (ix, iy) in ixiy {
            let (X, Y) = (x+ix, y+iy)
            if X < 0 || Y < 0 || X >= R || Y >= C || v[X][Y] || li[X][Y] != color { continue }
            
            v[X][Y] = true
            q.append((X, Y))
            ans.append((X, Y))
        }
    }
    
    return ans.count >= 4 ? ans : []
}

func grabity() {
    for j in 0..<C {
        var this = [String]()
        for i in (0..<R).reversed() where li[i][j] != "."{
            this.append(li[i][j])
        }
        while this.count < 12 {
            this.append(".")
        }
        this.reverse()
        for i in (0..<R).reversed() {
            li[i][j] = this[i]
        }
    }
}

var ans = 0
var isBoom = true
while isBoom {
    isBoom = false
    v = Array(repeating: Array(repeating: false, count: C), count: R)
    for i in 0..<R {
        for j in 0..<C where li[i][j] != "." {
            let this = boom(i, j)
            if !this.isEmpty {
                this.forEach { (x, y) in
                    li[x][y] = "."
                }
                isBoom = true
            }
        }
    }
    if !isBoom {
        break
    }
    grabity()
    ans += 1
}
print(ans)
