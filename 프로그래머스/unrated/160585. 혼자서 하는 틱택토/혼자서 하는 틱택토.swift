import Foundation

let lines = [[(0,0), (0,1), (0,2)],
             [(1,0), (1,1), (1,2)],
             [(2,0), (2,1), (2,2)],
             [(0,0), (1,0), (2,0)],
             [(0,1), (1,1), (2,1)],
             [(0,2), (1,2), (2,2)],
             [(0,0), (1,1), (2,2)],
             [(0,2), (1,1), (2,0)]]

func solution(_ board:[String]) -> Int {
    let li = board.map { $0.map{String($0)} }
    var (OWin, XWin, OCount, XCount) = (false, false, 0, 0)
    
    for i in li {
        for j in i {
            if j == "O" { OCount += 1 }
            else if j == "X" { XCount += 1 }
        }
    }
    
    for line in lines {
        var (O, X) = (0, 0)
        for (x, y) in line {
            if li[x][y] == "O" { O += 1 }
            else if li[x][y] == "X" { X += 1 }
        }
        if O == 3 { OWin = true }
        else if X == 3 { XWin = true }
    }
    
    if XCount > OCount { return 0 }
    if OCount < XCount { return 0 }
    if OCount > XCount + 1 { return 0 }
    if OWin && XWin { return 0 }
    if OWin && (OCount != 1+XCount) { return 0 }
    if XWin && (OCount != XCount) { return 0 }
    
    return 1
}
