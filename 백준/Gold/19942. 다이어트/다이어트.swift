import Foundation

let N = Int(readLine()!)!
let pfsv = readLine()!.split(separator: " ").map{Int($0)!}
let table = (0..<N).map { _ in readLine()!.split(separator: " ").map{Int($0)!} }

var ans = [Int]()
var ansprice = Int.max

for k in 1...N {
    var arr = [Int]()
    
    func check() {
        var success = true
        for i in 0..<4 where success {
            if pfsv[i] > arr.reduce(0) { $0 + table[$1][i] } {
                success = false
            }
        }
        if success {
            let price = arr.reduce(0) { $0 + table[$1][4] }
            if price < ansprice {
                ansprice = price
                ans = arr
            } else if price == ansprice {
                ans = arr.map{String($0)}.joined() < ans.map{String($0)}.joined() ? arr : ans
            }
        }
    }
    
    func myFunc(_ n: Int) {
        if arr.count == k { check(); return }
        for i in n..<N where !arr.contains(i) {
            arr.append(i)
            myFunc(i)
            arr.removeLast()
        }
    }
    myFunc(0)
}
if ansprice == .max {
    print(-1)
    exit(0)
}
print(ansprice)
print(ans.map { String($0+1) }.joined(separator: " "))


/*
 4
 100 100 100 100
 100 100 100 99 500
 100 100 100 100 1000
 1 1 99 34 501
 111 1 99 34 500
 
4
100 100 100 100
99 99 99 33 10
99 99 99 33 10
99 99 99 34 10
100 100 100 999 30
 */
