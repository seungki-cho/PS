import Foundation

let nt = readLine()!.split(separator: " ").map{ Int(String($0))! }
let (n, T) = (nt[0], nt[1])
struct Po: Hashable {
    var x: Int
    var y: Int
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    var pos: (Int, Int) { (x, y) }
}
var di = [Po: Int]()

(0..<n).forEach { _ in
    let xy = readLine()!.split(separator: " ").map{ Int($0)! }
    di[Po(xy[0], xy[1])] = Int.max
}
di[Po(0, 0)] = 0

var q = [Po(0, 0)]
func pos(po: Po) -> [Po] {
    var ans = [Po]()
    let (x, y) = po.pos
    for i in 0...2 {
        for j in 0...2 {
            for pm in [(1, 1), (1, -1), (-1, 1), (-1, -1)] {
                if let next = di[Po(x+i*pm.0, y+j*pm.1)],
                   next == Int.max {
                    ans.append(Po(x+i*pm.0, y+j*pm.1))
                }
            }
        }
    }
    return ans
}
while !q.isEmpty {
    let this = q.removeFirst()
    
    for po in pos(po: this) {
        di[po] = di[this]! + 1
        q.append(po)
        if po.y == T {
            print(di[this]! + 1)
            exit(0)
        }
    }
}
print(-1)
