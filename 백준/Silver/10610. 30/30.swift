import Foundation
var N = String(readLine()!).map{Int(String($0))!}.sorted(by: >)
print(N.last! == 0 && N.reduce(0, +) % 3 == 0 ? N.map{"\($0)"}.joined() : "-1")
