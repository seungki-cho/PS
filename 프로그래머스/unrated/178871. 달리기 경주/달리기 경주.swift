import Foundation

func solution(_ players:[String], _ callings:[String]) -> [String] {
    var 이름에대한순위 = players
    .enumerated()
    .reduce(into: [String: Int]()){$0[$1.element]=$1.offset}
    var 현재순위 = players
    
    callings.forEach { 추월할사람 in
        let 느린사람이름 = 현재순위[이름에대한순위[추월할사람]!-1]
        현재순위.swapAt(이름에대한순위[느린사람이름]!, 이름에대한순위[추월할사람]!)
        이름에대한순위[느린사람이름]! += 1
        이름에대한순위[추월할사람]! -= 1
    }
    return 현재순위
}