// Copyright (c) 2017, Joannis Orlandos. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:mongo_dart/mongo_dart.dart';

main(List<String> arguments) async {
  DateTime start = new DateTime.now();

  Db db = new Db("mongodb://localhost:27017/compare");
  await db.open();

  DbCollection users = db.collection("users");

  var documents = new List<Map>();
  var otherDocuments = new List<Map>();

  for(var i = 0; i < 10000; i++) {
    documents.add({
      "_id": new ObjectId(),
      "name_first": "Joannis",
      "name_last": "Orlandos",
      "age": 20,
      "programmer": true,
      "likes": [
        "mongodb", "swift", "programming", "swimming"
      ]
    });

    otherDocuments.add({
      "_id": new ObjectId(),
      "name_first": "Harriebob",
      "name_last": "Narwhal",
      "age": 42,
      "programmer": false,
      "likes": [
        "facebook", "golfing", "cooking", "reading"
      ]
    });
  }

  await users.insertAll(documents);
  await users.insertAll(otherDocuments);

  int counter = 0;

  await users.find(where.gt("age", 18)).forEach((user) {
    counter += 1;
  });

  int counter2 = 0;

  await users.find(where.eq("name_first", "Joannis")).forEach((user) {
    counter2 += 1;
  });

  await users.remove({});

  DateTime end = new DateTime.now();

  print(counter);
  print(counter2);
  print(end.difference(start));
  return;
}
