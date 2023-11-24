import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func r() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }
}
let f = FileIO()

//let nk = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, Q) = (f.r(), f.r())
var li = Array(repeating: 0, count: N)
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
print((0..<Q).map { _ in
//    let z = readLine()!.split{$0==" "}.map{Int($0)!}
    let (a,b,c) = (f.r(),f.r()-1,f.r())
    if a == 0 {
        return "\(part(0,li.count-1,1,min(b,c-1),max(b,c-1)))\n"
    } else {
        update(0, li.count-1, 1, b, b, c-li[b])
        li[b] = c
    }
    return ""
}.joined())
