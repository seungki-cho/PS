import Foundation
let choon = Int(readLine()!)!
let choo = readLine()!.split{$0==" "}.map{Int($0)!}
let T = Int(readLine()!)!
let tc = readLine()!.split{$0==" "}.map{Int($0)!}
var li = Array(repeating: false, count: 40000)//tc.max()!+1)

li[0] = true
for i in 0..<choo.count {
    let this = choo[i]
    for j in (0..<li.count).reversed() {
        if j-this >= 0 { li[j] = li[j] ? li[j] : li[j-this] }
    }
//    print(li.reduce("") { $0 + ($1 ? "1 " : "0 ")})
}
//print()
for i in 0..<choo.count {
    let this = choo[i]
    for j in (0..<li.count) {
        if j+this < li.count { li[j] = li[j] ? li[j] : li[j+this] }
    }
//    print(li.reduce("") { $0 + ($1 ? "1 " : "0 ")})
}
var ans = ""
//for i in 0..<sacks.count {
//    print(i, sacks[i])
//}
for i in 0..<tc.count {
    if tc[i] >= li.count { ans += "N "; continue }
    ans += li[tc[i]] ? "Y " : "N "
}
print(ans)
/*
4
3 3 3 1
12
1 2 3 4 5 6 7 8 9 10 11 12

4
10 10 10 1
1
29
 */
