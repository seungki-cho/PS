import Foundation

func myFunc(_ N: Int) {
    if zeros.count == N { print(sudoku.map { $0.map { "\($0)" }.joined(separator: " ") }.joined(separator: "\n")); exit(0) }
    let (x, y) = zeros[N]
    
    for i in 1...9 where possible(x, y, i) {
        sudoku[x][y] = i
        myFunc(N+1)
    }
    
    sudoku[x][y] = 0
}

func possible(_ x: Int, _ y: Int, _ n: Int) -> Bool {
    for i in 0..<9 where ((sudoku[i][y] == n && i != x) || (sudoku[x][i] == n && i != y)) {
        return false
    }
    for i in (x/3)*3..<(x/3)*3+3 where i != x {
        for j in (y/3)*3..<(y/3)*3+3 where (j != y && sudoku[i][j] == n) {
            return false
        }
    }
    return true
}

var (sudoku, zeros) = ([[Int]](), [(Int, Int)]())

for i in 0..<9 {
    sudoku.append(readLine()!.split{ $0 == " "}.map{Int($0)!})
    for j in 0..<9 where sudoku[i][j] == 0 {
        zeros.append((i, j))
    }
}

myFunc(0)
