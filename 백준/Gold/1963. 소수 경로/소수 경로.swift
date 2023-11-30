import Foundation

var isP = Array(repeating: true, count: 10000)
(isP[0], isP[1]) = (false, false)
for i in 2..<10000 {
    if !isP[i] {continue}
    for j in stride(from: i+i, to: 10000, by: i) {
        isP[j]=false
    }
}

for _ in 0..<Int(readLine()!)! {
    let ft = readLine()!.split{$0==" "}.map{Int($0)!}
    let (from, to) = (ft[0], ft[1])
    var q = [from]
    var isv = Array(repeating: -1, count: 10000)
    isv[from] = 0
    
    while !q.isEmpty {
        let this = q.removeFirst()
        if this == to {
            print(isv[this])
            break
        }
        let thisA = "\(this)".map{String($0)}
        
        for i in 0..<4 {
            for j in 0..<10 where !(i == 0 && j == 0){
                var local = thisA
                local[i] = "\(j)"
                let localint = Int(local.joined())!
                if isP[localint] && isv[localint] == -1 {
                    q.append(localint)
                    isv[localint] = isv[this] + 1
                }
            }
        }
    }
}
