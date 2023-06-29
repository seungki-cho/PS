import Foundation

let (A, B) = (readLine()!.map{Int(String($0))!}, readLine()!.map{Int(String($0))!})
let (a, b) = (A.count > B.count ? A : B, A.count <= B.count ? A : B)
let (an, bn) = (a.count, b.count)
var ans = Int.max

var base = Array(repeating: 0, count: 300)
for j in 0..<an {
    base[j+100] = a[j]
}


for i in -an...an {
    var base = base
    
    for j in 0..<bn {
        base[100+i+j] += b[j]
    }
    
    if !base.filter({$0 > 3}).isEmpty { continue }
    ans = min(ans, base.filter({$0 != 0}).count)
}

print(ans)
