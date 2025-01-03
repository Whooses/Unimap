const express = require("express");
const router = express.Router();
const db = require("../../db");

// Middleware to log requests for events
router.use((req, res, next) => {
    console.log(`Event request: ${req.method} ${req.url}`);
    next();
});

// GET /events - Get all events
router.get("/", async (req, res) => {
    try {
        // Fetch all events
        const [results] = await db.query("SELECT * FROM events");
        res.status(200).json(results);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

// GET /events/:id - Get a single event by ID
router.get("/:id", async (req, res) => {
    try {
        const eventID = parseInt(req.params.id);

        // Fetch the event with specific ID
        const result = await db.query("SELECT * FROM events WHERE id = ?", [
            eventID,
        ]);

        // Check if the event was found
        if (result.length() === 0) {
            return res.status(400).json({ message: "Event not found" });
        }

        res.status(200).json(result[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

// POST /events - Create a new event
router.post("/", async (req, res) => {
    try {
        const {
            title,
            description,
            date,
            location,
            organizer,
            imageUrl,
            isPublic,
        } = req.body;

        // Insert the new event
        const insertResults = await db.query(
            "INSERT INTO Events (title, description, date, location, organizer, imageUrl, isPublic) VALUES (?, ?, ?, ?, ?, ?, ?)",
            [title, description, date, location, organizer, imageUrl, isPublic]
        );

        // Fetch the newly created event
        const [event] = await db.query("SELECT * FROM Events WHERE id = ?", [
            insertResults.insertId,
        ]);

        // Send the event back to the client
        res.status(201).json(event[0]);
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

// PUT /events/:id - Update an existing event
router.put("/:id", async (req, res) => {
    try {
        const {
            title,
            description,
            date,
            location,
            organizer,
            imageUrl,
            isPublic,
        } = req.body;

        // Extract and parse the event ID from the URL
        const eventID = parseInt(req.params.id);

        // Update the event with the specific ID
        await db.query(
            "UPDATE events SET title = ?, description = ?, date = ?, location = ?, organizer = ?, imageUrl = ?, isPublic = ? WHERE id = ?",
            [title, description, date, location, organizer, imageUrl, isPublic, eventID] // Include eventID here
        );

        // Fetch the newly updated event
        const [event] = await db.query("SELECT * FROM events WHERE id = ?", [eventID]);

        // Check if the event exists
        if (event.length === 0) {
            return res.status(404).json({ message: "Event not found" });
        }

        // Return the updated event
        res.status(200).json(event[0]); // Fix: Remove curly braces
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

// DELETE /events/:id - Delete an event
router.delete("/:id", async (req, res) => {
    try {
        const eventID = parseInt(req.params.id);

        // Execute the DELETE query
        const [results] = await db.query("DELETE FROM events WHERE id = ?", [eventID]);

        // Check if the event was found and deleted
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: "Event not found" });
        }

        // Return success message
        res.status(200).json({ message: "Event deleted" }); // Fixed: Added semicolon
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Internal server error" });
    }
});

module.exports = router;
