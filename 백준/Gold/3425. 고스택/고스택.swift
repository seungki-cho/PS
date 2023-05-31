import Foundation

class Stack {
    enum StackError: Error {
        case pop, inv, dup, swp, add, sub, mul, div, mod
    }
    var stack = [Int]()
    
    func peek() throws -> Int {
        if stack.count != 1 { throw StackError.pop }
        return stack.last!
    }
    
    func append(_ x: Int) {
        stack.append(x)
    }
    func pop() throws -> Int {
        guard !stack.isEmpty else { throw StackError.pop }
        return stack.removeLast()
    }
    func inv() throws {
        guard !stack.isEmpty else { throw StackError.inv }
        stack[stack.count-1] *= -1
    }
    func dup() throws {
        guard !stack.isEmpty else { throw StackError.dup }
        stack.append(stack[stack.count-1])
    }
    func swp() throws {
        try [pop(), pop()].forEach{ stack.append($0) }
    }
    func add() throws {
        let a = try pop()+pop()
        if abs(a) > 1_000_000_000 {
            throw StackError.add
        }
        stack.append(a)
    }
    func sub() throws {
        let a = try -pop()+pop()
        if abs(a) > 1_000_000_000 {
            throw StackError.add
        }
        stack.append(a)
    }
    func mul() throws {
        let a = try pop()*pop()
        if abs(a) > 1_000_000_000 {
            throw StackError.add
        }
        stack.append(a)
    }
    func div() throws {
        let (a, b) = try (pop(), pop())
        guard a != 0 else { throw StackError.div }
        stack.append((abs(b) / abs(a)) * (a * b < 0 ? -1 : 1))
    }
    func mod() throws {
        let (a, b) = try (pop(), pop())
        guard a != 0 else { throw StackError.mod }
        stack.append((abs(b) % abs(a)) * (b < 0 ? -1 : 1))
    }
}


func doJob(_ str: String, _ s: Stack ) throws -> Stack {
    var s = s
    var str = str.split(separator: " ").map{String($0)}
    switch str[0] {
        case "NUM":
            s.append(Int(str[1])!)
        case "POP":
        _ = try s.pop()
        case "INV":
        try s.inv()
        case "DUP":
        try s.dup()
        case "SWP":
        try s.swp()
        case "ADD":
        try s.add()
        case "SUB":
        try s.sub()
        case "MUL":
        try s.mul()
        case "DIV":
        try s.div()
        default:
        try s.mod()
    }
    return s
}


while true {
    var ops = [String]()
    var flag = true
    while flag {
        let str = readLine()!.split(separator: " ")
        
        switch str[0] {
        case "QUIT":
            exit(0)
        case "END":
            flag = false
            break;
        default:
            ops.append(str.reduce("") { $0 + " " + $1})
        }
    }
    let t = Int(readLine()!)!
    
    for _ in 0..<t {
        let n = Int(readLine()!)!
        var stack = Stack()
        stack.append(n)
        
        var isError = false
        for i in 0..<ops.count {
            do {
                let s = try doJob(ops[i], stack)
                stack = s
            } catch {
                isError = true
            }
        }
        
        guard !isError, let pek = try? stack.peek() else {
            print("ERROR")
            continue
        }
        
        print(pek)
    }
    print()
    _ = readLine()!
}
