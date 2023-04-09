import Foundation

var isP = Array(repeating: true, count: 10001)
(isP[0], isP[1]) = (false, false)
for i in 2...10000 where isP[i] {
    for j in stride(from: i+i, through: 10000, by: i) {
        isP[j] = false
    }
}

var ans = ""
for _ in (0..<Int(readLine()!)!) {
    let n = Int(readLine()!)!
    var answers = [(Int, Int)]()
    for i in (2..<n/2+1).reversed() where isP[i] && isP[(n - i)] {
        answers.append((i, n-i))
    }
    ans += answers.max { $0.1 - $0.0 > $1.1 - $1.0 }.map { "\($0) \($1)\n" }!
}
print(ans)