import Foundation

func solution(_ cards1:[String], _ cards2:[String], _ goal:[String]) -> String {
    var (ret, c1, c2) = ("Yes", cards1, cards2)
    goal.forEach {
        if c1.first == $0 { c1.removeFirst() }
        else if c2.first == $0 { c2.removeFirst() }
        else { ret = "No"}
    }
    return ret
}