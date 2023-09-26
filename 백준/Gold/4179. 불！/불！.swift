import Foundation

let rc = readLine()!.split(separator: " ").map{Int($0)!}
let (r, c) = (rc[0], rc[1])
var li = (0..<r).map { _ in Array(readLine()!) }
var isChange = true
var isv = Array(repeating: Array(repeating: false, count: c), count: r)
var count = 0
var q = [(Int, Int)]()
var fq = [(Int, Int)]()

for i in 0..<r {
    for j in 0..<c where li[i][j] != "." && li[i][j] != "#" {
        isv[i][j] = true
        if li[i][j] == "J" {
            q.append((i, j))
        }
        if li[i][j] == "F" {
            fq.append((i, j))
        }
    }
}

while isChange {
    isChange = false
    count += 1
    
    var news = [(Int, Int)]()
    while !fq.isEmpty {
        let (i, j) = fq.removeFirst()
        for (ix, iy) in zip([0,0,1,-1], [1,-1,0,0]) where 0..<r ~= (i+ix) && 0..<c ~= (j+iy){
            let (x, y) = (i+ix, j+iy)
            if li[x][y] == "." && !isv[x][y] {
                li[x][y] = "F"
                news.append((x, y))
                isv[x][y] = true
            }
        }
    }
    fq = news
    
    news = [(Int, Int)]()
    while !q.isEmpty {
        let (i, j) = q.removeFirst()
        if i == 0 || i == r-1 || j == 0 || j == c-1 {
            print(count)
            exit(0)
        }
        for (ix, iy) in zip([0,0,1,-1], [1,-1,0,0]) where 0..<r ~= (i+ix) && 0..<c ~= (j+iy){
            let (x, y) = (i+ix, j+iy)
            if li[x][y] == "." && !isv[x][y] {
                news.append((x, y))
                isv[x][y] = true
                isChange = true
            }
        }
    }
    q = news
}
print("IMPOSSIBLE")

