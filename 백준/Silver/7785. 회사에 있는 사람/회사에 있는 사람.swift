let N = Int(readLine()!)!
var enter = [String: Bool]()

for i in 0..<N {
    let input = readLine()!.split(separator: " ").map{ String($0) }
    let (name, isEnter) = (input[0], input[1] == "enter")
    
    if isEnter {
        enter[name] = true
    } else {
        enter[name] = nil
    }
}

for a in enter.keys.sorted().reversed() {
    print(a)
}