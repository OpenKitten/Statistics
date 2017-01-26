import LogKitten
import MongoKitten
import Foundation



Logger.default.minimumLogLevel = DefaultLevel.debug.compareValue

func benchmark() throws -> Double {
    let start = Date()
    let db = try Database(mongoURL: "mongodb://localhost:27017/compare")
    let users = db["users"]


    let documents = [Document](repeating: [
        "name_first": "Joannis",
        "name_last": "Orlandos",
        "age": 20,
        "programmer": true,
        "likes": [
            "mongodb", "swift", "programming", "swimming"
            ] as Document
        ], count: 10_000)

    try users.insert(documents)

    let otherDocuments = [Document](repeating: [
        "name_first": "Harriebob",
        "name_last": "Narwhal",
        "age": 42,
        "programmer": false,
        "likes": [
            "facebook", "golfing", "cooking", "reading"
            ] as Document
        ], count: 10_000)





    try users.insert(otherDocuments)

    var counter = 0

    for _ in try users.find(matching: "age" > 18) {
        counter += 1
    }

    var counter2 = 0

    for _ in try users.find(matching: "name_first" == "Joannis") {
        counter2 += 1
    }

    try users.remove(matching: [:])

    let end = Date()

//    print(counter)
//    print(counter2)
    try db.server.disconnect()
    let spent = end.timeIntervalSince(start)
//    print(spent)
    return spent

}

func prepare() throws {
    let db = try Database(mongoURL: "mongodb://localhost:27017/compare")
    let users = db["users"]
    try users.remove(matching: [:])
    try db.server.disconnect()
}



func median(_ values: [Double]) -> Double? {
    let count = Double(values.count)
    if count == 0 { return nil }
    let sorted = values.sorted { $0 < $1 }

    if count.truncatingRemainder(dividingBy: 2) == 0 {
        let leftIndex = Int(count / 2 - 1)
        let leftValue = sorted[leftIndex]
        let rightValue = sorted[leftIndex + 1]
        return (leftValue + rightValue) / 2
    } else {
        return sorted[Int(count / 2)]
    }
}

try prepare()

var results = [Double]()

for i in 1..<70 {
//    print(i)
    results.append(try benchmark())
}

let max = results.reduce(0) { $0 > $1 ? $0 : $1 }
let min = results.reduce(max) { $0 < $1 ? $0 : $1 }
let average = results.reduce(0, +) / Double(results.count)

print("Max : \(max)")
print("Min : \(min)")
print("Average : \(average)")
if let median = median(results) {
    print("Median : \(median)")
}


