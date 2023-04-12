import Foundation

let nk = readLine()!.split(separator: " ").map{ Int($0)! }
let (n, k) = (nk[0], nk[1])

if n == 1{ print(1); exit(0)}
func 재(_ li: [Int]){
    if li.count == n { print(li[k-1]); exit(0) }
    
    var newli = Array(repeating: 0, count: li.count+1)
    newli[0] = 1
    newli[newli.count-1] = 1
    for i in 1..<li.count {
        newli[i] = li[i-1] + li[i]
    }
    재(newli)
}
재([1,1])
