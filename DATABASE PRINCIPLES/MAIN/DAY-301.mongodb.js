/* global use, db */
// Playground: Weight Challenge Queries

// CONNECTED TO MANGO DB VIA CONNECTION STRING AND USING DB THAT CREATED IN ATLAS CONSOLE WITH COLLECTION - 'participants'
use("WeightChallenge");

// INSERT
db.participants.insertMany([
  { name: "Alice", start_weight: 82, current_weight: 78, goal_weight: 70 },
  { name: "Bob", start_weight: 95, current_weight: 92, goal_weight: 85 },
  { name: "Charlie", start_weight: 70, current_weight: 68, goal_weight: 65 },
  { name: "Diana", start_weight: 88, current_weight: 81, goal_weight: 75 },
  { name: "Ethan", start_weight: 105, current_weight: 102, goal_weight: 95 },
  { name: "Fiona", start_weight: 64, current_weight: 60, goal_weight: 60 },
  { name: "George", start_weight: 110, current_weight: 109, goal_weight: 90 }
]);

// QUERIES
db.participants.find();

db.participants.find({ current_weight: { $gt: 80 } });

db.participants.find({ $expr: { $lte: [ "$current_weight", "$goal_weight" ] } });

db.participants.updateOne(
  { name: "Alice" },
  { $set: { current_weight: 75 } }
);

db.participants.countDocuments();

db.participants.aggregate([
  {
    $project: {
      name: 1,
      lost: { $subtract: ["$start_weight", "$current_weight"] }
    }
  },
  { $sort: { lost: -1 } },
  { $limit: 1 }
]);

db.participants.aggregate([
  {
    $project: {
      lost: { $subtract: ["$start_weight", "$current_weight"] }
    }
  },
  {
    $group: {
      _id: null,
      avg_lost: { $avg: "$lost" }
    }
  }
]);
