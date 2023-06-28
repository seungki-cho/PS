import Foundation

let nwl = readLine()!.split(separator: " ").map{Int($0)!}
let (n, w, l) = (nwl[0], nwl[1], nwl[2])

var li = readLine()!.split(separator: " ").reversed().map{Int($0)!}
var bri = Array(repeating: 0, count: w)
var ans = 0
var weight = 0
var queFirst = 0
var doneCount = 0

while true {
    if bri[queFirst] != 0 {
        weight -= bri[queFirst]
        doneCount += 1
    }
    
    if doneCount == n {
        break;
    }
    
    if let la = li.last, weight + la <= l && (queFirst + w) <= bri.count {
        weight += li.last!
        bri.append(li.removeLast())
    } else {
        bri.append(0)
    }
    
    queFirst += 1
    ans += 1
}

print(ans+1)
