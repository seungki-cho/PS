import Foundation

import Foundation

struct time {
    var sec: Int
    
    init(s: String) {
        let input = s.split(separator: ":").map {Int($0)!}
        sec = input[0]*60 + input[1]
    }
}

func timeToSec(_ s: String) -> Int {
    let input = s.split(separator: ":").map {Int($0)!}
    return input[0]*60 + input[1]
}

func solution(_ plans:[[String]]) -> [String] {
    var li = plans.sorted(by: {
        timeToSec($0[1]) < timeToSec($1[1])
    })
    
    var ongoing = [(String, Int)]() // name, start Time, remain time
    ongoing.append((li[0][0], Int(li[0][2])!))
    var startTime = [String: Int]()
    li.forEach {
        startTime[$0[0]] = timeToSec($0[1])
    }
    var ans = [String]()
    for i in 1..<li.count {
        let (name, start, time) = (li[i][0], li[i][1], li[i][2])
        let stt = timeToSec(start)
        
        var flag = true
        
        var before: Int = 0
        if let last = ongoing.last {
            before = startTime[last.0]!
        } else {
            flag = false
        }
        
        while flag{
            if let last = ongoing.last{
                if before + last.1 <= stt {
                    before += last.1
                    ans.append(last.0)
                    
                    ongoing.removeLast()
                } else {
                    ongoing[ongoing.count-1].1 = last.1 - (stt - before)
                    flag = false
                }
            } else {
                flag = false
            }
        }
        ongoing.append((name, Int(time)!))
    
    }
    return ans.map { $0 } + ongoing.reversed().map { $0.0 }
}
