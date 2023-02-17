import Foundation

func solution(_ storey:Int) -> Int {
    var li = String(storey).map{Int(String($0))!}
    
    let max = (0..<li.count).map{Int($0)}.reduce(1, { ini, _ in ini*2})

    if li.count == 1 {
        return [10 - li[0], li[0]].min()!
    }
    
    var answer = Int.max
    
    for i in 0..<max {
        var binary = String(i, radix: 2)
        (0..<li.count-binary.count).forEach{ _ in
            binary = "0"+binary
        }
        let isWin = binary.map { $0 == "1" }
        
        var thisLi = Array(li.reversed())
        var local = 0
        
        for i in 0..<li.count-1 {
            if thisLi[i] == 10 {
                thisLi[i+1] += 1
                continue
            }
            if isWin[i] {
                thisLi[i+1] += 1
                local += (10 - thisLi[i])
            } else {
                local += thisLi[i]
            }
        }
        if thisLi.last! == 10 {
            local += 1
        } else {
            local += [10 - thisLi.last! + 1, thisLi.last!].min()!
        }
        if local == 7{
            print(isWin, thisLi)
        }
        answer = answer > local ? local: answer
    }
    
    return answer
}

// print(solution(678)) // 16
