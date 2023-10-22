import Foundation
let nk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, K) = (nk[0], nk[1])
var (w, v) = ([Int](), [Int]())
(0..<N).forEach { _ in
    let wv = readLine()!.split{$0==" "}.map{Int($0)!}
    w.append(wv[0])
    v.append(wv[1])
}
var nap = Array(repeating: 0, count: K+1)
for i in (0..<N) {
    for j in stride(from: K, through: 1, by: -1) {
        if j >= w[i] {
            nap[j] = max(nap[j], nap[j-w[i]] + v[i])
        }
    }
}
print(nap[K])