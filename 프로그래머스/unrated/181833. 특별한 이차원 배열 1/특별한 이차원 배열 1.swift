import Foundation

func solution(_ n:Int) -> [[Int]] {
    return (0..<n).map { i in (0..<n).map { j in i==j ? 1 : 0 } }
}