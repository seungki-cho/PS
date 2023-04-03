import Foundation

func surToIndex(_ sur: String) -> Int {
    if sur.contains("R") {
        return 0
    } else if sur.contains("C") {
        return 1
    } else if sur.contains("J") {
        return 2
    } else {
        return 3
    }
}


func solution(_ survey:[String], _ choices:[Int]) -> String {
    var MBTI = [0, 0, 0, 0]
    var RCJA = [("R", "T"), ("C", "F"), ("J", "M"), ("A", "N")]
    var point = [0, 3, 2, 1, 0, -1, -2, -3]
    for (sur, cho) in zip(survey, choices) {
        var dir = 1 
        if ["TR", "FC", "MJ", "NA"].contains(sur) { dir = -1 }
        MBTI[surToIndex(sur)] += point[cho]*dir
        print(MBTI)
    }
    var ans = ""
    
    for (score, alpha) in zip(MBTI, RCJA) {
        ans += score >= 0 ? alpha.0 : alpha.1
    }
    
    return ans
}