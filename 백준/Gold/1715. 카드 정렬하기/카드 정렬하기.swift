import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {

        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

struct Heap<T> {
    private var heap: [T] = []
    private let compare: (_ a: T,_ b: T) -> Bool
    init(compare: @escaping (_ a: T, _ b: T) -> Bool) {
        self.compare = compare
    }

    private func leftChild(_ n: Int) -> Int {
        (n * 2) + 1
    }
    private func rightchild(_ n: Int) -> Int {
        (n + 1) * 2
    }
    private func parent(_ n: Int) -> Int {
        (n - 1) / 2
    }

    var isEmpty: Bool {
        heap.count == 0
    }

    var count: Int {
        heap.count
    }

    var top: T {
        heap[0]
    }

    mutating func push(_ n: T) {
        heap.append(n)

        var point = heap.count - 1

        while parent(point) >= 0 {
            if compare(heap[point], heap[parent(point)]) {
                heap.swapAt(point, parent(point))
            } else {
                break;
            }
            point = parent(point)
        }
    }

    mutating func pop() -> T? {
        if heap.count == 0 { return nil }
        if heap.count == 1 { return heap.removeLast() }

        heap.swapAt(heap.count-1, 0)
        let answer = heap.removeLast()
        var point = 0

        while leftChild(point) < heap.count {
            if leftChild(point) == heap.count-1{
                if !compare(heap[point], heap[leftChild(point)]) {
                    heap.swapAt(point, leftChild(point))
                }
                break;
            } else {
                let childPoint = compare(heap[leftChild(point)], heap[rightchild(point)]) ? leftChild(point) : rightchild(point)

                if !compare(heap[point], heap[childPoint]) {
                    heap.swapAt(point, childPoint)
                } else {
                    break;
                }
                point = childPoint
            }
        }
        return answer
    }
}

var fio = FileIO()

let N = fio.readInt()
var minHeap = Heap<Int>(compare: <)

(0..<N).forEach { _ in
    minHeap.push(fio.readInt())
}

var answer = 0

while minHeap.count > 1 {
    let this = minHeap.pop()! + minHeap.pop()!
    answer += this
    minHeap.push(this)
}
print(answer)
