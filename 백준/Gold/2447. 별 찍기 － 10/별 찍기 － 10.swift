import Foundation

let N = Int(readLine()!)!

func myFunc(_ n: Int, _ star: [String]) {
    if n == 1 {
        star.forEach { print($0) }
        return
    }
    
    let a = star.map { $0 + $0 + $0 }
    let b = star.map { $0 + (0..<$0.count).map { _ in  " " } + $0 }
    myFunc(n/3, a + b + a)
}
myFunc(N, ["*"])
