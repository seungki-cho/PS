import Foundation
var (li, str) = (["c=","c-","dz=","d-","lj","nj","s=","z="],readLine()!)
li.forEach{str=str.replacingOccurrences(of:$0,with:"@")}
print(str.count)
