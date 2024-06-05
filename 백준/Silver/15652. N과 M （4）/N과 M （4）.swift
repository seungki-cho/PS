import Foundation

let input = readLine()!.split{$0 == " "}.map{ Int($0)! }
let (N, M) = (input[0], input[1])

var arr: [Int] = []

func myFunc(idx: Int) {
    if arr.count == M {
        arr.map{ print($0,terminator: " ")}
        print()
        return
    }
    for i in idx...N {
        arr.append(i)
        myFunc(idx: i)
        arr.removeLast()
    }
}

myFunc(idx: 1)
