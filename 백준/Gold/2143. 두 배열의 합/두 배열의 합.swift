import Foundation
let (T, n, an, m, bn) = (Int(readLine()!)!, Int(readLine()!)!, readLine()!.split{$0==" "}.map{Int($0)!}, Int(readLine()!)!, readLine()!.split{$0==" "}.map{Int($0)!})
var (ali, bli) = ([Int](), [Int]())

for i in 0..<n {
    var tmp = 0
    for j in i..<n {
        tmp += an[j]
        ali.append(tmp)
    }
}
for i in 0..<m {
    var tmp = 0
    for j in i..<m {
        tmp += bn[j]
        bli.append(tmp)
    }
}

ali.sort()
bli.sort()

func bs(_ t: Int, _ compare: @escaping (Int, Int) -> Bool) -> Int {
    var (l, r) = (0, bli.count)
    
    while l < r {
        let m = ((r + l) / 2)
        if compare(bli[m], t) {
            l = m + 1
        } else {
            r = m
        }
    }
    return l
}

var ans = 0
for a in ali {
    ans += bs(T-a, <=) - bs(T-a, <)
}
print(ans)
