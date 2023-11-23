import Foundation
let nk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, K) = (nk[0], nk[1])
let li = (0..<N).map{_ in Int(readLine()!)!}
var st = Array(repeating: 0, count: N*4)
func make(_ l: Int, _ r: Int, _ i: Int) -> Int {
    st[i] = l == r ? li[l] : min(make(l,(l+r)/2,i*2), make(1+(l+r)/2,r,i*2+1))
    return st[i]
}
func part(_ l: Int, _ r: Int, _ i: Int, _ x:Int, _ y: Int) -> Int{
    x > r || y < l ? .max : (l>=x&&r<=y ? st[i] : min(part(l,(l+r)/2,i*2,x,y), part(1+(l+r)/2,r,i*2+1,x,y)))
}
make(0, li.count-1, 1)
(0..<K).forEach { _ in
    let a = readLine()!.split{$0==" "}.map{Int($0)!}
    print(part(0, li.count-1, 1, a[0]-1, a[1]-1))
}