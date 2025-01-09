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






// test
const { expressjwt: jwt } = require('express-jwt');
const jwksRsa = require('jwks-rsa');
const cors = require('cors');

// Enable CORS
app.use(cors());

// Middleware to validate JWT tokens
const checkJwt = jwt({
  secret: jwksRsa.expressJwtSecret({
    cache: true,
    rateLimit: true,
    jwksRequestsPerMinute: 5,
    jwksUri: `https://${process.env.AUTH0_DOMAIN}/.well-known/jwks.json`,
  }),
  audience: process.env.AUTH0_AUDIENCE,
  issuer: `https://${process.env.AUTH0_DOMAIN}/`,
  algorithms: ['RS256'],
});

// Protected route
app.get('/api/protected', checkJwt, (req, res) => {
  res.json({ message: 'This is a protected route!', user: req.user });
});

// Public route
app.get('/api/public', (req, res) => {
  res.json({ message: 'This is a public route!' });
});








// Start the server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});





