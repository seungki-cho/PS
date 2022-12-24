import Foundation

let input = Array(readLine()!).map{String($0)}
let boom = readLine()!
var stack = [String]()

for i in input {
    stack.append(i)
    if i == String(boom.last!),
       stack.count >= boom.count,
       stack[(stack.count - boom.count)...(stack.count-1)].joined() == boom{
        stack.removeLast(boom.count)
    }
}
print(stack.count == 0 ? "FRULA" : stack.joined())
