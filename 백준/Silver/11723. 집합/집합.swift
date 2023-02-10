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
var arr = Array(repeating: false, count: 20)

var n = fio.readInt()
var output = ""
(0..<n).forEach { _ in
    let input = fio.readStirngSum()
    
    switch input {
        case 297:
            arr[fio.readInt()-1] = true
        case 654:
            arr[fio.readInt()-1] = false
        case 510:
            output += arr[fio.readInt()-1] ? "1\n" : "0\n"
        case 642:
            arr[fio.readInt()-1].toggle()
        case 313:
            arr = Array(repeating: true, count: 20)
        case 559:
            arr = Array(repeating: false, count: 20)
        default:
            break
    }
}
print(output)

