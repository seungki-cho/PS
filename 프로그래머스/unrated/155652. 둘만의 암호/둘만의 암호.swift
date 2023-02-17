import Foundation
func solution(_ s:String, _ skip:String, _ index:Int) -> String {
    let code = "abcdefghijklmnopqrstuvwxyz".map { String($0) }.filter{ !skip.contains($0) }
    return s.map{String($0)}.map{ code[(index + code.firstIndex(of: $0)!)%code.count] }.joined()
}
