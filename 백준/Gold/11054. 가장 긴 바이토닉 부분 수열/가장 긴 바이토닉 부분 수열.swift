import Foundation
let N = Int(readLine()!)!
let li = readLine()!.split{$0==" "}.map{Int($0)!}

func bs(_ arr: [Int], _ n: Int) -> Int {
    var (l, r) = (0, arr.count-1)
    while l < r {
        let m = ( l + r ) / 2
        if arr[m] < n {
            l = m + 1
        } else if arr[m] > n {
            r = m
        } else {
            return m
        }
    }
    return l
}

func find(_ li: [Int]) -> [Int] {
    var dp = [li[0]]
    var index = [0]
    for i in 1..<N {
        if li[i] > dp.last! {
            dp.append(li[i])
            index.append(dp.count-1)
            continue
        }
        
        let p = bs(dp, li[i])
        dp[p] = li[i]
        index.append(p)
    }
    return index
}
let a = find(li)
let b = find(li.reversed()).reversed().map{Int($0)}
var ans = 0
for i in 0..<a.count {
    ans = max(ans, a[i] + b[i] + 1)
}
print(ans)
