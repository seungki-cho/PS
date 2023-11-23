import Foundation

let nmk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M, K) = (nmk[0], nmk[1], nmk[2])
var li = (0..<N).map { _ in Int(readLine()!)! }
var st = Array(repeating: 0, count: 4*N)

func make(_ l: Int, _ r: Int, _ i: Int) -> Int {
    if l == r {
        st[i] = li[l]
        return st[i]
    }
    let m = (l+r)/2
    st[i] = make(l, m, i*2) + make(m+1, r, i*2+1)
    return st[i]
}
func update(_ l: Int, _ r: Int, _ i: Int, _ x: Int, _ diff: Int) {
    if x < l || x > r {
        return
    }
    st[i] += diff
    if l == r { return }
    let m = (l+r)/2
    update(l, m, i*2, x, diff)
    update(m+1, r, i*2+1, x, diff)
}
func sum(_ l: Int, _ r: Int, _ i: Int, _ x: Int, _ y: Int) -> Int {
    if r < x || l > y {
        return 0
    }
    if l >= x && r <= y {
        return st[i]
    }
    let m = (l+r)/2
    return sum(l, m, i*2, x, y) + sum(m+1, r, i*2+1, x, y)
}
_=make(0, li.count-1, 1)
for _ in 0..<M+K {
    let abc = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a,b,c) = (abc[0], abc[1]-1, abc[2])
    if a == 1 {
        update(0, li.count-1, 1, b, c-li[b])
        li[b] = c
    } else {
        print(sum(0, li.count-1, 1, b, c-1))
    }
}
