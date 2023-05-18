import Foundation
for _ in 0..<Int(readLine()!)! {
    let N = Int(readLine()!)!
    let li = (0..<N).map { _ -> (Double, Double) in
        let x = readLine()!.split(separator: " ").map{Double($0)!}
        return (x[0], x[1])
    }
    
    var dp = [Int]()
    var ans = 100_000.0 * 21
    
    func dis(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) -> Double {
        let disX = Double((x2-x1)*(x2-x1))
        let disY = Double((y2-y1)*(y2-y1))
        return sqrt(disX + disY)
    }
    
    func myFunc() {
        if dp.count == N/2 {
            var (xx, yy) = (0.0, 0.0)
            var (x, y) = (0.0, 0.0)
            for (i, xy) in li.enumerated() {
                if dp.contains(i) {
                    (x, y) = (x + xy.0, y + xy.1)
                } else {
                    (xx, yy) = (xx + xy.0, yy + xy.1)
                }
            }
            ans = min(ans, dis(x, y, xx, yy))
            return
        }
        
        for i in (dp.last ?? 0)+1..<N where !dp.contains(i) {
            dp.append(i)
            myFunc()
            dp.removeLast()
        }
    }
    myFunc()
    print(ans)
}
