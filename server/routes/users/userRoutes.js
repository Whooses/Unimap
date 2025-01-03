const express = require('express');
const router = express.Router();
const db = require('../../db'); // Import the MySQL connection pool

router.use((req, res, next) => {
    console.log(`User request: ${req.method} ${req.url}`);
    next();
});


// Create a new user
router.post('/', async (req, res) => {
  try {
    const { username, email, password } = req.body;
    const [result] = await db.query(
      'INSERT INTO Users (username, email, password) VALUES (?, ?, ?)',
      [username, email, password]
    );
    res.status(201).json({ id: result.insertId, username, email });
  } catch (err) {
    console.error('Error creating user:', err);
    res.status(500).json({ error: 'Failed to create user' });
  }
});

// Get all users
router.get('/', async (req, res) => {
  try {
    const [results] = await db.query('SELECT * FROM Users');
    res.status(200).json(results);
  } catch (err) {
    console.error('Error fetching users:', err);
    res.status(500).json({ error: 'Failed to fetch users' });
  }
});

// Get a single user by ID
router.get('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const [results] = await db.query('SELECT * FROM Users WHERE id = ?', [userId]);
    if (results.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json(results[0]);
  } catch (err) {
    console.error('Error fetching user:', err);
    res.status(500).json({ error: 'Failed to fetch user' });
  }
});

// Update a user by ID
router.put('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const { username, email, password } = req.body;
    const [result] = await db.query(
      'UPDATE Users SET username = ?, email = ?, password = ? WHERE id = ?',
      [username, email, password, userId]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(200).json({ id: userId, username, email });
  } catch (err) {
    console.error('Error updating user:', err);
    res.status(500).json({ error: 'Failed to update user' });
  }
});

// Delete a user by ID
router.delete('/:id', async (req, res) => {
  try {
    const userId = req.params.id;
    const [result] = await db.query('DELETE FROM Users WHERE id = ?', [userId]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: 'User not found' });
    }
    res.status(204).send();
  } catch (err) {
    console.error('Error deleting user:', err);
    res.status(500).json({ error: 'Failed to delete user' });
  }
});

module.exports = router; // Export the router