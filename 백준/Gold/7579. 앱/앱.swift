import Foundation

let nmk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M) = (nmk[0], nmk[1])
let weights = readLine()!.split{$0==" "}.map{Int($0)!}
let costs = readLine()!.split{$0==" "}.map{Int($0)!}
let K = costs.reduce(0, +)
var nap = Array(repeating: 0, count: K+1)

for i in 0..<N {
    let (weight, cost) = (weights[i], costs[i])
    for j in (1...K).reversed() where cost <= j{
        nap[j] = max(nap[j], nap[j-cost] + weight)
    }
}
print(nap.enumerated().filter { $0.element >= M }.min { $0.offset < $1.offset }!.offset)
