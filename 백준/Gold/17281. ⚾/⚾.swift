import Foundation

var seq = [Int]()
var seqs = [[Int]]()
var c = 0

func myFunc() {
    if seq.count == 9 {
        seqs.append(seq)
        return
    }
    
    for i in 0..<9 where !seq.contains(i) && i != 0 {
        seq.append(i)
        if seq.count == 3 { seq.append(0) }
        myFunc()
        if let l = seq.last, l == 0 { seq.removeLast() }
        seq.removeLast()
    }
}

myFunc()
let N = Int(readLine()!)!
let li = (0..<N).map { _ in readLine()!.split{$0==" "}.map{Int($0)!}}
var ans = 0

for seq in seqs {
    var hitter = 0
    var score = 0
    for inning in 0..<N {
        var outCount = 0
        var base: [Bool] = Array(repeating: false, count: 3)

        while outCount < 3 {
            switch li[inning][seq[hitter]] {
            case 1:
                score += base[2] ? 1 : 0
                base[2] = base[1]
                base[1] = base[0]
                base[0] = true
            case 2:
                score += base[2] ? 1 : 0
                score += base[1] ? 1 : 0
                base[2] = base[0]
                base[1] = true
                base[0] = false
            case 3:
                score += base[2] ? 1 : 0
                score += base[1] ? 1 : 0
                score += base[0] ? 1 : 0
                base[2] = true
                base[1] = false
                base[0] = false
            case 4:
                score += base[2] ? 1 : 0
                score += base[1] ? 1 : 0
                score += base[0] ? 1 : 0
                score += 1
                base[2] = false
                base[1] = false
                base[0] = false
            default:
                outCount += 1
            }
            hitter = (hitter + 1)%9
        }
    }
    ans = max(ans, score)
}
print(ans)
