// main.js
require("dotenv").config();

// Import required modules
const mysql = require("mysql2/promise");
const express = require("express");
const bodyParser = require("body-parser");
// const cors = require('cors');

// Initialize the Express application
const app = express();

// Set the port for the server to listen on
const PORT = process.env.PORT;

// Middleware
// app.use(cors()); // Enable CORS for all routes
app.use(bodyParser.json()); // Parse incoming JSON requests
app.use(bodyParser.urlencoded({ extended: true })); // Parse URL-encoded bodies

// Routes
const userRoutes = require("./routes/users/userRoutes");
const eventRoutes = require("./routes/events/eventRoutes");
app.use("/users", userRoutes);
app.use("/events", eventRoutes);

// Error handling middleware
// app.use((err, req, res, next) => {
//   console.error(err.stack);
//   res.status(500).send('Something broke!');
// });

// Start the server
app.listen(PORT, () => {
    console.log(`Server is running on:`);
    console.log(`http://localhost:${PORT}`);
});

