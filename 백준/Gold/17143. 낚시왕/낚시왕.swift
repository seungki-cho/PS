import Foundation
let fuck = false
let rcm = readLine()!.split{$0==" "}.map{Int($0)!}
let (R, C, M) = (rcm[0], rcm[1], rcm[2])
var li = Array(repeating: Array(repeating: (0, 0, 0), count: C), count: R)
(0..<M).forEach { _ in
    let rcsdz = readLine()!.split{$0==" "}.map{Int($0)!}
    let (r, c, s, d, z) = (rcsdz[0]-1, rcsdz[1]-1, rcsdz[2], rcsdz[3], rcsdz[4])
    li[r][c] = (s, d, z)
}

func cal(dir: Int, _ x: Int, _ y: Int, _ s: Int) -> (Int, Int, Int) {
    switch dir {
    case 1: // up
        let (x, isup) = calLeft(x, s, true)
        return (x, y, isup ? 1 : 2)
    case 2: // down
        if s + x < R { return (s + x, y, 2) }
        let (x, isup) = calLeft(R-1, s-(R-1-x), true)
        return (x, y, isup ? 1 : 2)
    case 3: // right
        if s + y < C { return (x, s + y, 3) }
        let (y, isLeft) = calLeft(C-1, s-(C-1 - y), false)
        return (x, y, isLeft ? 4 : 3)
    default: // left
        let (y, isLeft) = calLeft(y, s, false)
        return (x, y, isLeft ? 4 : 3)
    }
}
func calLeft(_ y: Int, _ s: Int, _ isup: Bool) -> (Int, Bool) {
    let C = isup ? R: C
    if fuck{
        print(y,s,isup, "HI")
    }
    if y - s >= 0 { return (y-s, true) }
    let s = (s - y) % ((C - 1) * 2)
    
    if s < C {
        return (s, false)
    } else {
        return (C-2-(s%C), true)
    }
}
var ans = 0
for i in 0..<C {
    if fuck{
        for i in 0..<R {
            for j in 0..<C {
                print(li[i][j].2,terminator: " ")
            }
            print()
        }
        print()
    }
    if let r = (0..<R).first(where: { li[$0][i].2 != 0 }) {
        ans += li[r][i].2
//        print("GET :", li[r][i].2)
        li[r][i] = (0, 0, 0)
    }
    if fuck{
        for i in 0..<R {
            for j in 0..<C {
                print(li[i][j].2,terminator: " ")
            }
            print()
        }
        print("@@@@@@@")
    }
    var newli = Array(repeating: Array(repeating: (0, 0, 0), count: C), count: R)
    for x in 0..<R {
        for y in 0..<C where li[x][y].2 != 0 {
            let (X, Y, dir) = cal(dir: li[x][y].1, x, y, li[x][y].0)
            if fuck { print(x, y, li[x][y].1, "S:",li[x][y].0, "To", X, Y, dir, li[x][y].2) }
            if newli[X][Y].2 < li[x][y].2 {
                newli[X][Y].0 = li[x][y].0
                newli[X][Y].1 = dir
                newli[X][Y].2 = li[x][y].2
            }
        }
    }
    li = newli
    
}
print(ans)
/*
3 10 3
1 7 37 4 1
2 8 37 4 9
3 9 37 4 1
 */

