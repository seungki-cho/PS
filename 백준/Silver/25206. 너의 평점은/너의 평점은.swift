import Foundation

let dic = ["A+": 4.5, "B+": 3.5, "C+": 2.5, "D+": 1.5, "A0": 4.0, "B0": 3.0, "C0": 2.0, "D0": 1.0, "F": 0.0]
var total = 0.0
var 에 = 0.0

for _ in (0..<20) {
    let abc = readLine()!.split(separator: " ").map{String($0)}
    let (_, b, c) = (abc[0], Double(abc[1])!, dic[abc[2]])
    guard let c = c else { continue }
    total += b
    에 += b * c
}

print(에/total)
