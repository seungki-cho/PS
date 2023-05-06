import Foundation
for _ in 0..<Int(readLine()!)! {
    var (li, flag, fail) = (readLine()!.map{String($0)}, false, false)
    let n = li.count
    var (i, j) = (0, n-1)
    func isP(_ i: Int, _ j: Int, _ flag: Bool) -> Int {
        if i >= j {
            if flag {
                return 1
            }
            return 0
        }
        if li[i] != li[j] {
            if flag {
                return 2
            }
            if isP(i+1, j, true) != 2 {
                return 1
            }
            if isP(i, j-1, true) != 2 {
                return 1
            } else {
                return 2
            }
        }
        return isP(i+1, j-1, flag)
    }
    print(isP(0, n-1, false))
    
    
//    if fail {
//        print(2)
//    } else if flag {
//       print(1)
//    } else {
//        print(0)
//    }
    
}
