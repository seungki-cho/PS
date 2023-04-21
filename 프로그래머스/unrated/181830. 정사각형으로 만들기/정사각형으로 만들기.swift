
import Foundation

func solution(_ arr:[[Int]]) -> [[Int]] {
    var arr = arr
    
    if arr.count > arr[0].count {
        
        let 차이 = arr.count - arr[0].count
        for i in 0..<arr.count {
            for j in 0..<차이 {
                arr[i].append(0)
            }
        }
        return arr
        
    } else if  arr.count < arr[0].count {
        let zeros = arr[0].map{ _ in 0 }
        let 차이 = arr[0].count - arr.count
        for i in 0..<차이 {
            arr.append(zeros)
        }
        return arr
        
    } else {
        return arr
    }
}