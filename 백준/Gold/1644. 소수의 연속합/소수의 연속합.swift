import Foundation

var N = Int(readLine()!)!

var isPrime = Array(repeating: true, count: N+1)
(isPrime[0], isPrime[1]) = (false, false)
for i in 2..<isPrime.count {
    if isPrime[i], i+i <= isPrime.count-1 {
        for j in stride(from: i+i, through: isPrime.count-1, by: i) {
            isPrime[j] = false
        }
    }
}

var primes = isPrime.enumerated().filter { $0.element }.map{ $0.offset }
var answer = 0

for i in 0..<primes.count {
    if primes[i]*2 >= N {
        break;
    }
    for j in i..<primes.count {
        let subSum = primes[i...j].reduce(0, +)
        if subSum == N {
            answer += 1
            break
        } else if subSum > N {
            break
        }
    }
}
if isPrime[N] {
    answer += 1
}
print(answer)

