import Foundation
let NK = readLine()!.split(separator: " ").map{Int($0)!}
let (N, K) = (NK[0], NK[1])
var v = [Int: Int]()
var q = [N]
v[N] = 0
var i = 0

while i < q.count {
    let this = q[i]
    
    if this == K {
        break;
    }
    
    if this*2 < 200_001, v[this*2] == nil {
        v[this*2] = v[this]!
        q.append(this*2)
    }
    
    if v[this-1] == nil {
        v[this-1] = v[this]! + 1
        q.append(this-1)
    }
    if v[this+1] == nil {
        v[this+1] = v[this]! + 1
        q.append(this+1)
    }
    
    
    i += 1
}
print(v[K]!)
