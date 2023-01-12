import Foundation

func cal(_ inTime: String,_ outTime: String) -> Int {
    let (inTime, outTime) = (inTime.split{$0 == ":"}.map {Int($0)!}, outTime.split{$0 == ":"}.map {Int($0)!})
    
    let (inH, inM) = (inTime.first!, inTime.last!)
    let (outH, outM) = (outTime.first!, outTime.last!)
    return (outH - inH) * 60 + (outM - inM)
}

func solution(_ fees:[Int], _ records:[String]) -> [Int] {
    var parkingLot = [String: String]() // 차량 번호와 들어온 시간
    var receipt = [String: Int]() // 차량 번호와 주차 시간
    var records = records.map { $0.split(separator: " ").map{ String($0) }}
                         .sorted { $0[0] < $1[0]  }
    
    records.forEach { record in
        let (car, time, isIn) = (record[1], record[0], record[2] == "IN")
        if isIn {
            parkingLot[car] = time
        } else {
            receipt[car] = (receipt[car] ?? 0) + cal(parkingLot[car]!, time)
            parkingLot[car] = nil
        }
    }
    
    parkingLot.forEach { (car, time) in
        receipt[car] = (receipt[car] ?? 0) + cal(time, "23:59")
    }
    
    let sortedReceipt = Array(receipt)
                            .sorted { $0.key < $1.key }
                            .map { ($0.key, Double($0.value)) }

    let fee = fees.map{ Double($0) }
    
    return sortedReceipt.map { (car, min) in
                              if min < fee[0] {
                                  return Int(fee[1])
                              }
                              let I = min - fee[0]
                              let II = I / fee[2]
                              let III = ceil(II)
                              let IV = III * fee[3]
                              let V = fee[1] + IV
                              let VI = Int(V)
                              return VI
    }
}