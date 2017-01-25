import LogKitten
import MongoKitten
import Foundation

let start = Date()

Logger.default.minimumLogLevel = DefaultLevel.error.compareValue

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

for user in try users.find(matching: "age" > 18) {
    counter += 1
}

var counter2 = 0

for user in try users.find(matching: "name_first" == "Joannis") {
    counter2 += 1
}

try users.remove(matching: [:])

let end = Date()

print(counter)
print(counter2)
print(end.timeIntervalSince(start))
