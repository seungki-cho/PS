import Foundation
func solution(_ name:[String], _ yearning:[Int], _ photo:[[String]]) -> [Int] {
    var dic = [String: Int]()
    (0..<name.count).forEach { dic[name[$0]] = yearning[$0]}
    return photo.map { $0.reduce(0, { $0 + (dic[$1] ?? 0)}) }
}
