import Foundation
let nmt = readLine()!.split{$0==" "}.map{Int($0)!}
let (N, M, T) = (nmt[0], nmt[1], nmt[2])
var li = (0..<N).map { _ in readLine()!.split{$0==" "}.map{Int($0)!} }
var ixiy = [(0, 1), (0, -1), (1, 0), (-1, 0)]
func spin(_ x: Int, _ d: Int, _ k: Int) {
    let k = d == 0 ? M-k : k
    for i in 0..<N where (i+1)%x == 0 {
        var newli = [Int]()
        for j in 0..<M {
            newli.append(li[i][(j+k)%M])
        }
        li[i] = newli
    }
}
func avg() {
    var sum = 0
    var count = 0
    
    for i in 0..<N {
        for j in 0..<M where li[i][j] != 0{
            sum += li[i][j]
            count += 1
        }
    }
    let avg = Double(sum) / Double(count)
//    print("avg :", avg)
    for i in 0..<N {
        for j in 0..<M where li[i][j] != 0{
            if Double(li[i][j]) > avg {
                li[i][j] -= 1
            } else if Double(li[i][j]) < avg {
                li[i][j] += 1
            }
        }
    }
}

func boom() -> Bool {
    var isv = Array(repeating: Array(repeating: false, count: M), count: N)
    var isBoom = false
    
    func bfs(_ a: Int, _ b: Int) {
        var isLocalBoom = false
        var q = [(a, b)]
        isv[a][b] = true
        while !q.isEmpty {
            let (x, y) = q.removeLast()
            for (ix, iy) in ixiy {
                var (X, Y) = (x+ix, y+iy)
                if Y == -1 { Y = M-1 }
                else if Y == M { Y = 0 }
                guard (0..<N) ~= X,
                      li[X][Y] == li[a][b],
                      !isv[X][Y] else { continue }
                isv[X][Y] = true
                li[X][Y] = 0
                isBoom = true
                isLocalBoom = true
                q.append((X, Y))
            }
        }
        if isLocalBoom {
            li[a][b] = 0
        }
    }
    
    for i in 0..<N {
        for j in 0..<M where !isv[i][j] && li[i][j] != 0 {
            bfs(i, j)
        }
    }
    return isBoom
}
func printf() {
    return
    for i in 0..<N {
        for j in 0..<M {
            print(li[i][j], terminator: " ")
        }
        print()
    }
}

for i in 0..<T {
    let xdk = readLine()!.split{$0==" "}.map{Int($0)!}
    let (x, d, k) = (xdk[0], xdk[1], xdk[2])
    spin(x, d, k)
    printf()
    if !boom() {
        printf()
        avg()
        printf()
    }else {
        printf()
    }
}
print(li.flatMap { $0.flatMap { $0 }}.reduce(0, +))
/*
 4 6 3
 2 3 4 5 5 5
 5 6 3 4 5 5
 4 5 5 5 6 7
 7 8 5 5 5 6
 3 0 1
 */
