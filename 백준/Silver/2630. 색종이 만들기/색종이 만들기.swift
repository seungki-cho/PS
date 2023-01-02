
func blueWhite(x:Int,y:Int,n:Int)-> (Int,Int){
    
    
    if x>=N || y>=N{
        return (0,0)
    }
    if n==1 && di[x][y] == 1{
//        print("\(x),\(y) = = \(1)")
        return (1,0)
    }else if n==1 && di[x][y] == 0{
//        print("\(x),\(y) = = \(0)")
        return (0,1)
    }
    
    var count = 0
    var sumC = 0
    for i in x..<x+n{
        for j in y..<y+n{
            count = count + 1
            sumC = sumC + di[i][j]
        }
    }
    
    var b = 0
    var w = 0
    if count == sumC {//blue
        return (1,0)
    }else if sumC == 0{
        return (0,1)
    }else{
//        print("this is \(x) , \(y) , \(n), \(sumC), \(count)")
        var ret = blueWhite(x: x+n/2, y: y+n/2, n: n/2)
        b = b + ret.0
        w = w + ret.1

        ret = blueWhite(x: x, y: y+n/2, n: n/2)
        b = b + ret.0
        w = w + ret.1

        ret = blueWhite(x: x+n/2, y: y, n: n/2)
        b = b + ret.0
        w = w + ret.1

        ret = blueWhite(x: x, y: y, n: n/2)
        b = b + ret.0
        w = w + ret.1

    }
    return (b,w)
}

let N = Int(readLine()!)!

var di:[[Int]] = [[Int]]()

for _ in 0..<N{
    di.append(readLine()!.split(separator: " ").map{Int(String($0))!})
}

var ret = blueWhite(x: 0, y: 0, n: N)

print(ret.1)
print(ret.0)

