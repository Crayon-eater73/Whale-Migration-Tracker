const express = require('express');
const mysql = require('mysql2');
const path = require('path');

const app = express();
const PORT = 3000;

// Connect to your MySQL database
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',      
    password: 'bL@ckbu!!s12',      
    database: 'whale_tracker'
});

db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL database:', err.message);
    } else {
        console.log('Connected to the MySQL database.');
    }
});

app.use(express.static(path.join(__dirname)));

// 1. API endpoint for Species & Threat Levels
app.get('/api/species', (req, res) => {
    db.query('SELECT species_name, threat_level FROM species_name;', (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ data: results });
    });
});

// 2. API endpoint for Tracking Stations & Regions
app.get('/api/locations', (req, res) => {
    db.query('SELECT location, region FROM locations;', (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ data: results });
    });
});

// 3. API endpoint for Active Whale Telemetry
app.get('/api/whales', (req, res) => {
    const query = `
        SELECT 
            w.whale_id,
            w.whale_name,
            s_name.species_name AS species,
            l.location AS region,
            l.location AS coordinates,
            s.sighting_date AS sighted_date
        FROM whales w
        JOIN species_name s_name ON w.species_name = s_name.species_name
        JOIN locations l ON w.last_location = l.location
        JOIN sightings s ON w.whale_id = s.whale_id;
    `;

    db.query(query, (err, results) => {
        if (err) {
            res.status(500).json({ error: err.message });
            return;
        }
        res.json({ data: results });
    });
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
