import Foundation

class FileIO {
    @inline(__always) private var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], byteIdx = 0
    
    @inline(__always) private func readByte() -> UInt8 {
        defer { byteIdx += 1 }
        return buffer.withUnsafeBufferPointer { $0[byteIdx] }
    }
    
    @inline(__always) func readInt() -> Int {
        var number = 0, byte = readByte(), isNegative = false
        while byte == 10 || byte == 32 { byte = readByte() }
        if byte == 45 { byte = readByte(); isNegative = true }
        while 48...57 ~= byte { number = number * 10 + Int(byte - 48); byte = readByte() }
        return number * (isNegative ? -1 : 1)
    }
    
    @inline(__always) func readStirngSum() -> Int {
        var byte = readByte()
        while byte == 10 || byte == 32 { byte = readByte() }
        var sum = Int(byte)
        while byte != 10 && byte != 32 && byte != 0 { byte = readByte(); sum += Int(byte) }
        return sum - Int(byte)
    }
    
    @inline(__always) private func write(_ output: String) {
        FileHandle.standardOutput.write(output.data(using: .utf8)!)
    }
}

let fio = FileIO()
let (N, M) = (fio.readInt(), fio.readInt())
var inDegree = Array(repeating: 0, count: N+1)
inDegree[0] = -1

var adj = Array(repeating: [Int](), count: N+1)


for _ in 0..<M {
    let (a, b) = (fio.readInt(), fio.readInt())
    inDegree[b] += 1
    adj[a].append(b)
}

var stack = inDegree.enumerated().filter { $0.element == 0 }.map { $0.offset }
var answer = [Int]()

while !stack.isEmpty {
    let this = stack.removeLast()

    for point in adj[this]{
        inDegree[point] -= 1
        if inDegree[point] == 0 {
            stack.append(point)
        }
    }
    
    answer.append(this)
}

print(answer.map { String($0) }.joined(separator: " "))
