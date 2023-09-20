import Foundation
let N = readLine()!.split{$0==" "}.map{Int($0)!}
var v = readLine()!.split{$0==" "}.map{Int($0)!}
var (n,s,m) = (N[0], [N[1]], N[2])
for v in v {
    var b = Set<Int>()
    for s in s {
        if 0...N[2] ~= (s + v) { b.insert(s+v) }
        if 0...N[2] ~= (s - v) { b.insert(s-v) }
    }
    s = Array(b)
}
print(s.max() ?? -1)
