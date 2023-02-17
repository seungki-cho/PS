import Foundation

func solution(_ weights:[Int]) -> Int64 {
    var li = Array(repeating: 0, count: 1001)
    weights.forEach { li[$0] += 1 }
    func isNumber(_ n: Double) -> Bool { (n - Double(Int(n))) == 0.0 }
    
    let same = li.filter { $0 > 1}.map { ($0*($0-1)/2) }.reduce(0,+)
    let diff = weights.map {
        var ret = 0
        let (v, v2, v3) = (Double($0)*1.5, $0*2, Double($0)*4/3)
        if isNumber(v), Int(v)<li.count { ret += li[Int(v)] }
        if v2<li.count { ret += li[v2] }
        if isNumber(v3), Int(v3)<li.count { ret += li[Int(v3)] }
        
        return ret
    }.reduce(0, +)
    return Int64(same + diff)
}
