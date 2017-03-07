#!/usr/bin/env ruby
# encoding: utf-8

require 'mongo'

Mongo::Logger.logger.level = ::Logger::INFO

startTime = Time.now

mongoClient = Mongo::Client.new(['localhost:27017'], :database => 'compare')
collection = mongoClient[:users]

documents = Array.new(10000, { name_first: 'Joannis', 
                        name_last: 'Orlandos', 
                        age: 20, 
                        programmer:true, 
                        likes: ["mongodb", "swift", "programming", "swimming"] })

collection.insert_many(documents)

otherDocuments = Array.new(10000,{ name_first: 'Harriebob', 
                        name_last: 'Narwhal', 
                        age: 42, 
                        programmer:false, 
                        likes: ["facebook", "golfing", "cooking", "reading"] })
collection.insert_many(otherDocuments)                        

counter = 0 
collection.find({'age' => { '$gt' => 18}}).each { |document| 
    counter = counter + document[:age]
}
puts counter

counter2 = 0
collection.find({'name_first' => 'Joannis'}).each { |document|
    counter2 = counter2 + document[:age]
}
puts counter2


collection.delete_many({})

endTime = Time.now

puts endTime - startTime
