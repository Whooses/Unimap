CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Assumes hashed passwords are stored
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    date DATETIME NOT NULL,
    location VARCHAR(255),
    organizer INT, -- Foreign key to User table
    imageUrl VARCHAR(2083), -- URL for event image
    isPublic BOOLEAN NOT NULL DEFAULT TRUE, -- Visibility status
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (organizer) REFERENCES Users(id)
);

CREATE TABLE UserSavedEvents (
    userId INT NOT NULL,
    eventId INT NOT NULL,
    PRIMARY KEY (userId, eventId),
    FOREIGN KEY (userId) REFERENCES Users(id),
    FOREIGN KEY (eventId) REFERENCES Events(id)
);
