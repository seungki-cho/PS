import Foundation
var li = (0..<9).map { _->(Bool, Int) in
    let ab = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a, b) = (ab[0] == 1, ab[1]-1)
    return (a, b)
}

var hubo = [Int]()
for i in 0..<9 {
    var dp: [Bool?] = Array(repeating: nil, count: 9)
    li[i].0.toggle()
    var isSuccess = true
    
    for j in 0..<9 where isSuccess{
        let (isReal, n) = li[j]
        
        if dp[n] == nil || dp[n] == isReal { dp[n] = isReal }
        else if dp[n] != nil && dp[n] != isReal { isSuccess = false }
    }
    li[i].0.toggle()
    if !isSuccess { continue }

    
    if dp.filter({ $0 != nil && $0! }).count == 1 {
        hubo.append(dp.firstIndex(where: { $0 != nil && $0! })!)
    } else if dp.filter({ $0 != nil && !$0!}).count == 8 {
        hubo.append(dp.firstIndex(where: { $0 != nil && $0! }) ?? dp.firstIndex(where: { $0 == nil })!)
    } else if dp.filter { $0 != nil && $0! }.count == 0, 2...7 ~= dp.filter({ $0 != nil && !$0! }).count {
        print(-1)
        exit(0)
    }
    
}

print(Set(hubo).count == 1 ? hubo[0]+1 : -1)
