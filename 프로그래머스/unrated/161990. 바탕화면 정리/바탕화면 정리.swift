import Foundation

func solution(_ wallpaper:[String]) -> [Int] {
    var arr = wallpaper.map{ Array($0).map { String($0) }}
    var (a, b, c, d) = (Int.max, Int.max, -1, -1)
    
    for i in 0..<arr.count {
        for j in 0..<arr[0].count where arr[i][j] == "#" {
            a = [a, i].min()!
            b = [b, j].min()!
            c = [c, i+1].max()!
            d = [d, j+1].max()!
        }
    }
    
    return [a, b, c, d]
}