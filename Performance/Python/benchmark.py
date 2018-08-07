import time

from pymongo import MongoClient

start_time = time.time()

mongo_client = MongoClient('localhost:27017')
collection = mongo_client.compare.users

documents = [
    {'name_first': 'Joannis',
     'name_last': 'Orlandos',
     'age': 20,
     'programmer': True,
     'likes': ["mongodb", "swift", "programming", "swimming"]}
    for _ in range(10000)]

collection.insert_many(documents)

other_documents = [
    {'name_first': 'Harriebob',
     'name_last': 'Narwhal',
     'age': 42,
     'programmer': False,
     'likes': ["facebook", "golfing", "cooking", "reading"]}
    for _ in range(10000)]

collection.insert_many(other_documents)

counter = 0
for _ in collection.find({'age': {'$gt': 18}}):
    counter += 1
print(counter)

counter2 = 0
for _ in collection.find({'name_first': 'Joannis'}):
    counter2 += 1
print(counter2)


collection.delete_many({})

end_time = time.time()

print(end_time - start_time)
