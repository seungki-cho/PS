import Foundation

let s = readLine()!
var t = readLine()!

while t.count >= s.count {
    if t == s { print(1); exit(0) }
    if t.last! == "A" {
        t.removeLast()
    } else{
        t.removeLast()
        t = String(t.reversed())
    }
}
print(0)
