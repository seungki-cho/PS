import Foundation

func solution(_ data:[[Int]], _ col:Int, _ row_begin:Int, _ row_end:Int) -> Int {
    var data = data.sorted{ $0[0] > $1[0] }.sorted { $0[col-1] < $1[col-1] }
    var answer = 0
    for i in stride(from: row_begin-1, through: row_end-1, by: 1) {
        answer ^= data[i].reduce(0) { $0 + ($1 % (i+1)) }
    }
    return answer
}
