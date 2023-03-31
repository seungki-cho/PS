import Foundation

func solution(_ picks:[Int], _ minerals:[String]) -> Int {
    var (li, picks) = ([Int](), picks.reversed().map{Int($0)})
    
    for i in 0..<Int(ceil(Double(minerals.count)/5.0)) where i < picks.reduce(0, +) {
        var cost = 0
        for j in 0..<5 where i*5 + j < minerals.count {
            switch minerals[i*5+j]{
            case "diamond":
                cost += 5
            case "iron":
                cost += 1
            default:
                cost += 0
            }
        }
        li.append(cost)
    }
    
    var pickOrder = Array(repeating: 0, count: li.count)
    
    li.enumerated().sorted { $0.element > $1.element }.forEach { (index, element) in
        if picks.last! == 0 { picks.removeLast() }
        if picks.last! == 0 { picks.removeLast() }
        if picks.last! == 0 { picks.removeLast() }
        if picks.last! == 0 { picks.removeLast() }
        if picks.last! == 0 { picks.removeLast() }
        if picks.last! > 0 { picks[picks.count-1] -= 1 }
        pickOrder[index] = picks.count
        if picks.last! == 0 { picks.removeLast() }
    }
    
    var answer = 0
    
    func getCost(_ pType: Int, _ mineral: String) -> Int {
        switch pType {
        case 1:
            if mineral == "diamond" { return 25 }
            if mineral == "iron" { return 5 }
            fallthrough
        case 2:
            if mineral == "diamond" { return 5 }
            fallthrough
        default:
            return 1
        }
    }
    
    for i in 0..<pickOrder.count {
        for j in 0..<5 where i*5 + j < minerals.count {
            answer += getCost(pickOrder[i], minerals[i*5+j])
        }
    }
    
    
    return answer
}