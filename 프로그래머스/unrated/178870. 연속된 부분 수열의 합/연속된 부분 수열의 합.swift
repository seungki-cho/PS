import Foundation

func solution(_ sequence:[Int], _ k:Int) -> [Int] {
    var (p1, p2, li) = (0, 0, sequence)
    for i in 1..<sequence.count { li[i] += li[i-1] }
    var ans = [(Int, Int)]()
    var sum = 0
    
    while true {
        if sum >= k {
            if sum == k {
                ans.append((p1, p2-1))
            }
            sum -= sequence[p1]
            p1 += 1
        } else if p2 == sequence.count {
            break;
        } else {
            sum += sequence[p2]
            p2 += 1
        }
    }
    
    var answer = ans.sorted{ $0.0 < $1.0 }.sorted{ $0.1 - $0.0 < $1.1 - $1.0 }[0]
    return [answer.0, answer.1]
}