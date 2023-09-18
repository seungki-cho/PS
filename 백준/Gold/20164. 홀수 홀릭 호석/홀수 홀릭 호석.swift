import Foundation

let N = Int(readLine()!)!

func digit(_ n: Int) -> Int { String(n).count }

func oddOne(_ n: Int) -> Int {
    n.description.map{ Int(String($0))! }.reduce(0) { ini, next in
        ini + (next % 2 == 0 ? 0 : 1)
    }

}

func arrToInt(_ arr: ArraySlice<Int>) -> Int {
    Int(arr.map { String($0) }.joined())!
}

func myFunc(_ n: Int) -> (Int, Int) {
    let odd = oddOne(n)
    if digit(n) == 1 { return (odd, odd) }
    if digit(n) == 2 {
        let t = myFunc(n/10+n%10)
        return (t.0 + odd, t.1 + odd)
    }
    let arr = n.description.map { Int(String($0))! }
    var minSum = Int.max
    var maxSum = 0
    
    for i in 0..<arr.count-2 {
        for j in i+1..<arr.count-1 {
            let k = j+1
            let next = arrToInt(arr[0...i]) + arrToInt(arr[i+1...j]) + arrToInt(arr[k..<arr.count])
            let this = myFunc(next)
            minSum = min(minSum, this.0)
            maxSum = max(maxSum, this.1)
        }
    }
    
    return (odd + minSum, odd + maxSum)
}

let ans = myFunc(N)
print(ans.0, ans.1)
