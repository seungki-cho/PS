let input = readLine()!.split{$0 == " "}.map{Int($0)!}
let (n,m) = (input[0], input[1])
var arr = [Int]()

func myFunc() {
    if arr.count == m {
        arr.forEach{print($0,terminator: " ")}
        print()
    }
    
    for i in 1...n {
        if arr.contains(i){
            continue
        }
        arr.append(i)
        myFunc()
        arr.removeLast()
    }
}
myFunc()
