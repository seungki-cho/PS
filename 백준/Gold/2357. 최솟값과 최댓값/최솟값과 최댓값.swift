import Foundation
let nm=readLine()!.split{$0==" "}.map{Int($0)!}
let (N,M)=(nm[0],nm[1])
let li=(0..<N).map{_ in Int(readLine()!)!}
class ST {
    var st=Array(repeating: 0, count: 4*N)
    var z:Int
    var c: (Int, Int)->Int
    init(_ z: Int, _ c: @escaping (Int, Int) -> Int) { self.c = c; self.z=z; make(0, li.count-1, 1) }
    func make(_ l: Int, _ r: Int, _ i: Int) -> Int{
        if l == r {st[i] = li[l];return st[i]}
        let m=(l+r)/2
        st[i] = c(make(l, m, i*2),make(m+1, r, i*2+1))
        return st[i]
    }
    func p(_ x:Int, _ y: Int) -> Int {
        return part(0,N-1,1,x,y)
    }
    func part(_ l: Int, _ r: Int, _ i: Int, _ x: Int, _ y: Int) -> Int {
        if x > r || y < l { return z }
        if l>=x&&y>=r{ return st[i] }
        let m=(l+r)/2
        return c(part(l, m, i*2, x, y), part(m+1, r, i*2+1, x, y))
    }
}
let a=ST(Int.min,max)
let b=ST(Int.max,min)
(0..<M).map{_ in
    let l=readLine()!.split{$0==" "}.map{Int($0)!}
    let (x,y)=(l[0]-1,l[1]-1)
    print("\(b.p(x, y)) \(a.p(x, y))")
}
