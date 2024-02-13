
var N = Int(readLine()!)!
var li:[(s:Int,e:Int)] = []
for _ in 0..<N{
    let input = readLine()!.split(separator: " ").map{Int(String($0))!}
    li.append((s:input[0],e:input[1]))
}
li.sort{$0.s<$1.s}
li.sort{$0.e<$1.e}

var this:(s:Int,e:Int) = li[0]
var i = 1
var count = 1

while true{
    if i==li.count{
        break
    }
    if li[i].s >= this.e{
        count = count + 1
        this = li[i]
    }
    i = i + 1
}

print(count)

