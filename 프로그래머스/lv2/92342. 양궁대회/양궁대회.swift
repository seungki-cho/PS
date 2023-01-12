import Foundation

func solution(_ n:Int, _ info:[Int]) -> [Int] {
    var (answer, max) = (Array(repeating: 0, count: 11), 0)

    (1...2047).forEach { i in
        var binary = String(i, radix: 2)
        (0..<11-binary.count).forEach{ _ in
            binary = "0"+binary
        }
        let isWin = binary.map{ $0 == "1" }
        
        var (localAnswer, localMax) = (Array(repeating: 0, count: 11), 0)
        zip(info, isWin).enumerated().forEach{ idx, value in
            if value.1 {
                localAnswer[idx] = value.0+1
                localMax += 10-idx
            } else {
                localMax -= value.0 != 0 ? 10-idx : 0
            }
        }
        
        let shotCount = localAnswer.reduce(0, +)
        if binary == "01101000000"{
//            print(binary, localAnswer, localMax)
        }
        if shotCount <= n && localMax >= max {
            localAnswer[10] += shotCount < n ? (n - shotCount) : 0
            if localMax == max,
               localAnswer.lastIndex(where: {$0 > 0})! < answer.lastIndex(where: {$0 > 0}) ?? 12{
                return
            }
            answer = localAnswer
            max = localMax
//            print(binary, localAnswer, localMax)
        }
        
    }
    if answer.reduce(0, +) == 0 {
        return [-1]
    }
    return answer
}

 //print(solution(9, [0, 0, 1, 2, 0, 1, 1, 1, 1, 1, 1]))
