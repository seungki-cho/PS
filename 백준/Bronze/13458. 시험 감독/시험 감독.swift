import Foundation
let (N, Ai, BV) = (Int(readLine()!)!, readLine()!.split{$0==" "}.map{Double($0)!}, readLine()!.split{$0==" "}.map{Double($0)!})
print(Int(Ai.reduce(0, {$0 + (($1 - BV[0]) <= 0 ? 1 : (ceil(($1 - BV[0])/BV[1])+1))})))
