import Foundation

let n = Int(readLine()!)!
var li = Array(repeating: 0, count: n+1)
var maxi = Array(repeating: 1, count: n+1)

func 정수니(_ d: Double) -> Bool {
    d - Double(Int(d)) == 0
}


for i in 1...n {
    if 정수니(sqrt(Double(i))) { li[i] = 1; maxi[i] = Int(sqrt(Double(i))); continue }
    li[i] = min(li[i-1]+1, li[i-maxi[i-1]*maxi[i-1]]+1)
    for j in 1..<Int(sqrt(Double(i))) {
        li[i] = min(li[i], li[i-j*j]+1)
    }
    maxi[i] = maxi[i-1]
}
//print(li)
print(li[n])