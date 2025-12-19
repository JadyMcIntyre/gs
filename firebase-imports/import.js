import fs from "fs";
import csv from "csv-parser";
import admin from "firebase-admin";

admin.initializeApp({
    credential: admin.credential.cert("./serviceAccountKey.json"),
});

const db = admin.firestore();

const mentors = [];

fs.createReadStream("mentors.csv")
    .pipe(csv())
    .on("data", (row) => {
        mentors.push({
            first_name: row.first_name,
            last_name: row.last_name,
            expertise: row.expertise,
            description: row.description,
            tags: row.tags.split("|").map(t => t.trim()),
        });
    })
    .on("end", async () => {
        for (const mentor of mentors) {
            await db.collection("mentors").add(mentor);
        }
        console.log("Mentors imported successfully");
        process.exit();
    });
