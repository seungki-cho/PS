import Foundation

class Queue{
    var enq = [[Int]]()
    var deq = [[Int]]()
    
    var count: Int{
        return enq.count + deq.count
    }
    
    func push(_ a:[Int]){
        enq.append(a)
    }
    
    func pop()->[Int]{
        if deq.count == 0{
            deq = enq.reversed()
            enq.removeAll()
        }
        if deq.count == 0{
            return [-1,-1]
        }
        return deq.popLast()!
    }
}
let input = readLine()!.split(separator: " ").map{Int(String($0))!}

let n = input[0]
let m = input[1]

var visit = Array(repeating: false, count: 100_001)
var queue = Queue()
var di: [Int:Int] = [:]

queue.push([n,0])
visit[n] = true


func check(_ n:Int)->Bool{
    if n > 100_000 || n<0 || visit[n]{
        return false
    }
    return true
}

while queue.count != 0{
    let tmp = queue.pop()
    let this = tmp[0]
    let depth = tmp[1]
    if this == m{
        print(depth)
        break
    }
    if check(this+1){
        visit[this+1] = true
        queue.push([this+1,depth+1])
    }
    if check(this-1){
        visit[this-1] = true
        queue.push([this-1,depth+1])
    }
    if check(this*2){
        visit[this*2] = true
        queue.push([this*2,depth+1])
    }
}


