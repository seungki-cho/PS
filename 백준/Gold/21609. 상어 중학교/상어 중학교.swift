import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M) = (nm[0], nm[1])
var li = (0..<N).map { _ in readLine()!.split{$0==" "}.map{Int($0)!} }
var isv = Array(repeating: Array(repeating: false, count: N), count: N)
let ixiy = [(0, 1), (0, -1), (1, 0), (-1, 0)]
var ans = 0

func bfs(_ x: Int, _ y: Int) -> (Int, Int, [(Int, Int)]) { // return 블록 개수, 무지개 개수, 연결된 블럭 좌표
    isv[x][y] = true
    var (localVisit, q, rain, block, blocks) = (Array(repeating: Array(repeating: false, count: N), count: N), [(x, y)], 0, 1, [(x, y)])
    let color = li[x][y]
    
    while !q.isEmpty {
        let (x, y) = q.removeLast()
        for (ix, iy) in ixiy {
            let (X, Y) = (x+ix, y+iy)
            guard (0..<N) ~= X && (0..<N) ~= Y,
                  color == li[X][Y] || li[X][Y] == 0,
                  !isv[X][Y],
                  !localVisit[X][Y] else { continue }
            rain += li[X][Y] == 0 ? 1 : 0
            block += 1
            localVisit[X][Y] = true
            isv[X][Y] = li[X][Y] == 0 ? false : true
            blocks.append((X, Y))
            q.append((X, Y))
        }
    }
    
    return (block, rain, blocks)
}

func boom() -> Bool{
    var (block, rain, blocks) = (0, 0, [(Int, Int)]())
    isv = Array(repeating: Array(repeating: false, count: N), count: N)
    for i in 0..<N {
        for j in 0..<N where li[i][j] > 0 && !isv[i][j] {
            let (tblock, train, tblocks) = bfs(i, j)
            if tblocks.count == 1 { continue }
            if block < tblock ||
                (rain < train && block == tblock) {
                (block, rain, blocks) = (tblock, train, tblocks)
                continue
            }
            if block == tblock, rain == train,
               i > blocks.first!.0 ||
                (i == blocks.first!.0 && j > blocks.first!.1) {
                (block, rain, blocks) = (tblock, train, tblocks)
            }
        }
    }
    ans += block*block
    blocks.forEach { (x, y) in
        li[x][y] = -2
    }
    return !blocks.isEmpty
}

func gravity() {
    for i in 0..<N {
        var j = N-1
        while j != -1 {
            if li[j][i] == -2 {
                var (q, s) = ([Int](), j)
                while j-1 != -1, li[j-1][i] != -1 {
                    j -= 1
                    if li[j][i] != -2 {
                        q.append(li[j][i])
                    }
                    li[j][i] = -2
                }
                for k in 0..<q.count {
                    li[s-k][i] = q[k]
                }
            }
            j -= 1
        }
    }
}

func rotate() {
    var newli = Array(repeating: Array(repeating: 0, count: N), count: N)
    for i in 0..<N {
        let y = N-1-i
        for j in 0..<N{
            let x = j
            newli[i][j] = li[x][y]
        }
    }
    li = newli
}
func printf() {
//    for i in 0..<N {
//        for j in 0..<N {
//            print(li[i][j] == -2 ? "@" : li[i][j], terminator: " ")
//        }
//        print()
//    }
//    print()
}
while boom() {
    printf()
    gravity()
    rotate()
    gravity()
    printf()
}
print(ans)
