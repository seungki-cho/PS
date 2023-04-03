import Foundation

func solution(_ ingredient:[Int]) -> Int {
    var (s, ans) = ([Int](), 0)
    for a in ingredient {
        s.append(a)
        if s.count >= 4,
           s[s.count-4..<s.count] == [1, 2, 3, 1] {
            s.removeLast(4)
            ans += 1
        }
    }
    return ans
}