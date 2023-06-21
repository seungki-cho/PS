import Foundation

let nm = readLine()!.split(separator: " ").map{Int($0)!}
let (n, m) = (nm[0], nm[1])
var li = Array(repeating: Array(repeating: 0, count: 2), count: 3)

var input = readLine()!.split(separator: " ").map{Int($0)!}
for i in 0..<3 {
    li[i][0] = input[i]
}
input = readLine()!.split(separator: " ").map{Int($0)!}
for i in 0..<3 {
    li[i][1] = input[i]
}

var arr = [Int]()
var local = 0
var ans = 0

func myFunc() {
    if arr.count == n {
        if local >= m{
            ans += 1
        }
        return
    }
    
    for i in 0..<3 {
        for j in 0..<2 {
            if let l = arr.last, l == i {
                local += li[i][j]/2
                arr.append(i)
                myFunc()
                local -= li[i][j]/2
                arr.removeLast()
            } else {
                local += li[i][j]
                arr.append(i)
                myFunc()
                arr.removeLast()
                local -= li[i][j]
            }
        }
    }
}

myFunc()
print(ans)

