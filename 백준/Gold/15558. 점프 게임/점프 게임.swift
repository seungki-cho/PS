import Foundation

let NK = readLine()!.split(separator: " ").map{Int($0)!}
let (n, k) = (NK[0], NK[1])
var li = [[Int]]()
li.append(readLine()!.map{Int(String($0))!})
li.append(readLine()!.map{Int(String($0))!})
var v = Array(repeating: Array(repeating: false, count: n), count: 2)
var q = [(0, 0)]
var die = -1
v[0][0] = true

while !q.isEmpty {
    var this = q
    q.removeAll()
    
    for (x, y) in this {
        if y == die {
            continue
        }
        
        if y+1 < n {
            if !v[x][y+1], li[x][y+1] == 1 {
                q.append((x, y+1))
                v[x][y+1] = true
            }
        } else {
            print(1)
            exit(0)
        }
        
        if y-1 >= 0, !v[x][y-1], li[x][y-1] == 1{
            q.append((x, y-1))
            v[x][y-1] = true
        }
        
        if y+k < n {
            if !v[(x+1)%2][y+k], li[(x+1)%2][y+k] == 1 {
                q.append(((x+1)%2, y+k))
                v[(x+1)%2][y+k] = true
            }
        } else {
            print(1)
            exit(0)
        }
    }
    
    die += 1
}
print(0)
