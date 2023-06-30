import Foundation

enum Dir: Int, CaseIterable {
    case ld = 1, d, rd, l, x, r, lu, u, ru
    
    static var dirArr: [(Int, Int)] {[(1, -1), (1, 0), (1, 1), (0, -1), (0, 0), (0, 1), (-1, -1), (-1, 0), (-1, 1)]}
    var dir: (Int, Int) { Dir.dirArr[self.rawValue-1] }
    func compute(_ mine: (Int, Int)) -> (Int, Int) {
        (self.dir.0 + mine.0, self.dir.1 + mine.1)
    }
}

let rc = readLine()!.split(separator: " ").map{Int($0)!}
let (r, c) = (rc[0], rc[1])
var li = [[String]]()
var kraj: Int?
var (mx, my) = (0, 0)

func fuc() {
    for i in 0..<r {
        for j in 0..<c {
            print(li[i][j], terminator: "")
        }
        print()
    }
}


for _ in 0..<r {
    li.append(readLine()!.map{String($0)})
}

for i in 0..<r {
    for j in 0..<c {
        if li[i][j] == "I" { (mx, my) = (i, j) }
    }
}

let dirs = readLine()!.map{Int(String($0))!}
for k in 0..<dirs.count where kraj == nil {
    let d = dirs[k]
    
    li[mx][my] = "."
    (mx, my) = Dir(rawValue: d)!.compute((mx, my))
    if li[mx][my] == "R" {
        kraj = k
        break;
    }
    li[mx][my] = "I"
    
    var psycho = Array(repeating: Array(repeating: ".", count: c), count: r)
    
    var michins = [(Int, Int)]()
    for i in 0..<r {
        for j in 0..<c where li[i][j] == "R"{
            michins.append((i, j))
        }
    }
    
    for michin in michins {
        let (x, y) = michin
        let (nx, ny) = Dir.allCases.min {
            let (ax, ay) = $0.dir
            let (bx, by) = $1.dir
            return (abs(x - mx + ax) + abs(y - my + ay)) < (abs(x - mx + bx) + abs(y - my + by))
        }!.compute((x, y))
        li[x][y] = "."
        
        if psycho[nx][ny] == "." {
            psycho[nx][ny] = "R"
        } else if psycho[nx][ny] == "R" || psycho[nx][ny] == "B"{
            psycho[nx][ny] = "B"
        }
    }
    
    for i in 0..<r {
        for j in 0..<c where psycho[i][j] != "." {
            if li[i][j] == "I" {
                kraj = k
            }
            if psycho[i][j] == "B" {
                li[i][j] = "."
            } else if psycho[i][j] == "R" {
                li[i][j] = "R"
            }
        }
    }
    
    for i in 0..<r {
        for j in 0..<c where li[i][j] == "B" {
            li[i][j] = "."
        }
    }
}

if let kraj = kraj {
    print("kraj", kraj+1)
} else {
    fuc()
}
