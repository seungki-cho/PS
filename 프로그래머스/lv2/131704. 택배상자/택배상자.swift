import Foundation

func solution(_ order:[Int]) -> Int {
    var (arr, s, ans) = ((1...order.count).reversed().map{$0}, [Int](), 0)
    
    for o in order {
        while arr.count > 0 || s.count > 0 {
            if let l = arr.last, o == l {
                arr.removeLast()
                ans += 1
                break;
            } else if let l = s.last, o == l {
                s.removeLast()
                ans += 1
                break;
            }
            
            if arr.count > 0 {
                s.append(arr.removeLast())
            } else {
                return ans
            }
        }
    }
    return ans
}
//print(solution([4, 3, 1, 2, 5])) // 2
//print(solution([5, 4, 3, 2, 1])) // 5
