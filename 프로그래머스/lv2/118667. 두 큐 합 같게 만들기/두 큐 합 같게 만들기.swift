import Foundation

func solution(_ queue1:[Int], _ queue2:[Int]) -> Int {
    var (queue1, queue2) = (queue1, queue2)
    var (a, b, pa, pb, ret, aN, bN, N) = (queue1.reduce(0, +), queue2.reduce(0, +), 0, 0, 0, queue1.count, queue2.count, queue1.count)
    var n = b - a
    
    if n == 0 { return 0 }
    while true {
        if n < 0 {
            if pa < aN {
                n += 2*queue1[pa]
                queue2.append(queue1[pa])
                bN += 1
                pa += 1
            } else {
                return -1
            }
        } else if n > 0 {
            if pb < bN {
                n -= 2*queue2[pb]
                queue1.append(queue2[pb])
                aN += 1
                pb += 1
            } else {
                return -1
            }
        } else {
            return ret
        }
        ret += 1
        
        if ret > N*2+10 {
            return -1
        }
    }
    
    return -1
}