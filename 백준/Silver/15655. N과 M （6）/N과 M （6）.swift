let input = readLine()!.split{$0 == " "}.map{Int($0)!}
let (n,m) = (input[0], input[1])
let tmp = readLine()!.split{$0 == " "}.map{Int($0)!}.sorted()
var arr = [Int]()

func myFunc() {
    if arr.count == m {
        arr.forEach{print($0, terminator: " ")}
        print()
        return
    }
    
    for i in tmp {
        if let a = arr.last{
            if a >= i{
                continue
            }
        }
        arr.append(i)
        myFunc()
        arr.removeLast()
    }
}
myFunc()
