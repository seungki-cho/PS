import Foundation

func solution(_ want:[String], _ number:[Int], _ discount:[String]) -> Int {
    var answer = 0
    for i in 0..<discount.count {
        var remains = [String: Int]()
        number.enumerated().forEach { remains[want[$0.offset]] = $0.element }
        for j in 0..<10 where i + j < discount.count && remains[discount[i+j]] != nil {
            remains[discount[i+j]]! -= 1
        }
        answer += remains.values.filter { $0 > 0 }.count == 0 ? 1 : 0
    }
    return answer
}