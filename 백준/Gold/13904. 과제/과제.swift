import Foundation
var li = (0..<Int(readLine()!)!).map{ _ -> (Int, Int) in
    let t = readLine()!.split{$0==" "}.map{Int($0)!}
    return (t[0], t[1])
}
li.sort { $0.1 > $1.1 }
li.sort { $0.0 > $1.0 }
var ans = 0
var hubo = [Int]()

for i in (1...1000).reversed() {
    hubo = hubo + li.filter { $0.0 == i }.map { $0.1 }
    hubo.sort(by: >)
    ans += (hubo.isEmpty ? 0 : hubo.removeFirst())
}
print(ans)
