import Foundation
let nm = readLine()!.split(separator: " ").map{ Int($0)! }
var (n, m, li, mySeq) = (nm[0], nm[1], [String](), [String: Int]())
for i in 0..<m {
    li.append(readLine()!)
    mySeq[li[i]] = i
}
let 뚱이 = mySeq.sorted(by: { $0.value < $1.value }).map{ $0.key }
if 뚱이.count > n {
    print(뚱이[0..<n].joined(separator: "\n"))
} else{
    print(뚱이.joined(separator: "\n"))
}
