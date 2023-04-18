import Foundation

let hw = Int(readLine()!)!
var li = readLine()!.split(separator: " ").map{ Int($0)! }
var arr = [Int]()
arr.append(li.removeLast())

while arr.count != hw {
    if arr.first! % 2 == 0, let this = li.firstIndex(of: arr.first! / 2) {
        arr.insert(li.remove(at: this), at: 0)
    }
    if let this = li.firstIndex(of: arr.last! * 2) {
        arr.append(li.remove(at: this))
    }
    if arr.last! % 3 == 0, let this = li.firstIndex(of: arr.last! / 3) {
        arr.append(li.remove(at: this))
    }
    if let this = li.firstIndex(of: arr.first! * 3) {
        arr.insert(li.remove(at: this), at: 0)
    }
}

print(arr.map{"\($0) " }.joined())
