import Foundation
let nk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, Q) = (nk[0], nk[1])
var li = readLine()!.split{$0==" "}.map{Int($0)!}
var st = Array(repeating: 0, count: 4*N)
func make(_ l: Int, _ r: Int, _ i: Int) -> Int {
    st[i] = l==r ? li[l] : (make(l, (l+r)/2, i*2)+make(1+(l+r)/2,r,i*2+1))
    return st[i]
}
func update(_ l: Int, _ r: Int, _ i: Int, _ x: Int, _ y: Int, _ d: Int){
    if l > y || r < x { return }
    st[i] += d
    if l == r { return }
    update(l, (l+r)/2, i*2, x, y, d)
    update(1+(l+r)/2, r, i*2+1, x, y, d)
}
func part(_ l: Int, _ r: Int, _ i: Int, _ x: Int, _ y: Int) -> Int{
    if l > y || r < x { return 0 }
    if x <= l && y >= r { return st[i] }
    return part(l, (l+r)/2, i*2, x, y) + part(1+(l+r)/2, r, i*2+1, x, y)
}
make(0, li.count-1, 1)
(0..<Q).forEach { _ in
    let z = readLine()!.split{$0==" "}.map{Int($0)!}
    let (x,y,a,b) = (min(z[0],z[1])-1, max(z[0],z[1])-1, z[2]-1, z[3])
    print(part(0,li.count-1,1,x,y))
    update(0, li.count-1, 1, a, a, b-li[a])
    li[a] = b
}
