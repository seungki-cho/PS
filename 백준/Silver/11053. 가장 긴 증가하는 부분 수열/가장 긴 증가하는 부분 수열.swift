import Foundation

_ = readLine()!
var li = readLine()!.split(separator: " ").map{Int($0)!}
var arr = Array(repeating: 1, count: li.count)


for i in 0..<li.count {
    var this = li[0...i]
        .enumerated()
        .filter { $0.element < li[i] }
        .max { arr[$0.offset] < arr[$1.offset] }
            
    if let this = this {
        arr[i] = arr[this.offset] + 1
    }
}
print(arr.max()!)
