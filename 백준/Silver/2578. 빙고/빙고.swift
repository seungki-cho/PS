import Foundation
var board = (0..<5).map { _ in readLine()!.split(separator: " ").map{Int($0)!} }
let mc = (0..<5).map { _ in readLine()!.split(separator: " ").map{Int($0)!} }.flatMap { $0 }

for i in (0..<mc.count) {
    for k in 0..<5 {
        for j in 0..<5 {
            if board[k][j] == mc[i] {
                board[k][j] = 0
            }
        }
    }
    
    var vc = 0
    
    for i in 0..<5 {
        var ia = false
        var ib = false
        
        for j in 0..<5 {
            if board[i][j] != 0 { ia = true }
            if board[j][i] != 0 { ib = true }
        }
        
        if !ia { vc += 1 }
        if !ib { vc += 1 }
    }
    var ia = false
    var ib = false
    for i in 0..<5 {
        if board[i][i] != 0 { ia = true }
        if board[4-i][i] != 0 { ib = true }
    }
    if !ia { vc += 1 }
    if !ib { vc += 1 }
    
    if vc >= 3 {
        print(i+1)
        exit(0)
    }
}
