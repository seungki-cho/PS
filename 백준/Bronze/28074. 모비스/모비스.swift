import Foundation

let a = readLine()!.map{String($0)}

if a.contains("M") && a.contains("O") && a.contains("B") && a.contains("I"), a.contains("S") {
    print("YES")
} else {
    print("NO")
}
