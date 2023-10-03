import Foundation

let T = Int(readLine()!)!
struct Pos: Hashable {
    let x: Int
    let y: Int
    
    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
    
    func distanceTo(_ to: Pos) -> Int {
        abs(x - to.x) + abs(y - to.y)
    }
    
    func isLinked(_ to: Pos) -> Bool {
        distanceTo(to) <= 1000
    }
}

for _ in 0..<T {
    let con = Int(readLine()!)!
    let homexy = readLine()!.split{$0==" "}.map{Int($0)!}
    let home = Pos(homexy[0], homexy[1])
    
    let conveniences = (0..<con).map { _ -> Pos in
        let xy = readLine()!.split{$0==" "}.map{Int($0)!}
        return Pos(xy[0], xy[1])
    }
    var cons = Set(conveniences)
    
    let fxy = readLine()!.split{$0==" "}.map{Int($0)!}
    let finish = Pos(fxy[0], fxy[1])
    
    var q = [home]
    var isFinish = home.isLinked(finish)
    
    while !q.isEmpty && !isFinish {
        let this = q.removeFirst()
        let linked = cons.filter { $0.isLinked(this) }
        cons = cons.subtracting(linked)
        linked.forEach { isFinish = $0.isLinked(finish) ? true : isFinish }
        q.append(contentsOf: linked)
    }
    print(isFinish ? "happy" : "sad")
}
