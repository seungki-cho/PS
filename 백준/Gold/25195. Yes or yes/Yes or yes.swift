import Foundation

let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let (n, m) = (nm[0], nm[1])
var adj = Array(repeating: [Int](), count: n)
var isDead = Array(repeating: false, count: n)
(0..<m).forEach { _ in
    let ab = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a, b) = (ab[0]-1, ab[1]-1)
    adj[a].append(b)
}
_=readLine()!
readLine()!.split{$0==" "}.forEach { isDead[Int($0)!-1] = true }

var isv = Array(repeating: false, count: n)
isv[0] = true

func myFunc(_ n: Int) {
    if isDead[n] == true { return }
    
    if adj[n].count == 0 {
        print("yes")
        exit(0)
    }
    
    for to in adj[n] where !isv[to] {
        isv[to] = true
        myFunc(to)
        isv[to] = false
    }
    
}

myFunc(0)
print("Yes")
