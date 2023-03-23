import Foundation

var input = readLine()!.split { $0 == " "}.map { Int($0)! }
let (N, K) = (input[0], input[1])

var time = Array(repeating: 0, count: N+1)
var inDegree = Array(repeating: 0, count: N+1)
inDegree[0] = -1
var adj = Array(repeating: [Int](), count: N+1)

for _ in 0..<K {
    input = readLine()!.split { $0 == " "}.map { Int($0)! }
    input.removeFirst()
    
    for i in 0..<input.count {
        for j in i+1..<input.count {
            inDegree[input[j]] += 1
            adj[input[i]].append(input[j])
        }
    }
}

var stack = inDegree.enumerated().filter { $0.element == 0 }.map { $0.offset }
var answer = [Int]()
var parents = Array(repeating: [Int](), count: N+1)

while !stack.isEmpty {
    let from = stack.removeLast()

    for point in adj[from]{
        inDegree[point] -= 1
        if inDegree[point] == 0 {
            stack.append(point)
        }
        parents[point].append(from)
    }
    answer.append(from)
}
if answer.count != N {
    print(0)
    exit(0)
}
answer.forEach { print($0) }
/*
6 3
3 1 4 3
4 6 2 5 4
2 2 3
 */
