import Foundation

func bs(_ li: [Int], _ l: Int, _ r: Int, _ t: Int) -> Int {
    var (l, r) = (l, r)
    while l < r {
        let m = (l+r)/2
        if li[m] < t {
            l = m + 1
        } else if li[m] > t {
            r = m
        } else {
            return m
        }
    }
    return l
}

let N = Int(readLine()!)!
let a = readLine()!.split{$0==" "}.map{Int($0)!}
let b = readLine()!.split{$0==" "}.map{Int($0)!}
var dic = Dictionary(uniqueKeysWithValues: b.enumerated().map{($0.element, $0.offset)})
var t: [Int] = a.map { dic[$0]! }.reversed()
t.reverse()

var li = [t[0]]

for i in (1..<N) {
    if li.last! < t[i] {
        li.append(t[i])
        continue
    }
    let pos = bs(li, 0, li.count-1, t[i])
    li[pos] = t[i]
}

print(li.count)
