CREATE DATABASE IF NOT EXISTS whale_tracker;
USE whale_tracker;

-- so I can run it mutiple times and not comment it out cause its annoying
DROP TABLE IF EXISTS sightings;
DROP TABLE IF EXISTS whales;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS species_name;

-- species
CREATE TABLE species_name (
    species_name VARCHAR(100) PRIMARY KEY,
    threat_level VARCHAR(50)
);

INSERT INTO species_name (species_name, threat_level)
VALUES
('North Atlantic right whale (Eubalaena glacialis)', 'Critically endangered'),
('Humpback whale (Megaptera novaeangliae)', 'Endangered'),
('Blue whale', 'Endangered'),
('Fin whale (Balaenoptera physalus)', 'Vulnerable'),
('Common minke whale (Balaenoptera acutorostrata)', 'Vulnerable'),
('Sei whale (Balaenoptera borealis)', 'Least Concern'),
('Sperm whale (Physeter macrocephalus)', 'Least Concern'),
('Cuviers beaked whale (Ziphius cavirostris)', 'Least Concern'),
('Beluga whale (Delphinapterus leucas)', 'Least Concern'),
('Orca / Killer whale (Orcinus orca)', 'Varies by population'),
('Southern right whale', 'Least Concern');

-- locations
CREATE TABLE locations (
    location VARCHAR(50) PRIMARY KEY,
    region VARCHAR(100)
);

INSERT INTO locations (location, region)
VALUES
('Gulf of St. Lawrence', 'Canada'),
('Cape Cod Bay', 'USA'),
('Stellwagen Bank', 'Gulf of Maine, USA'),
('South Shore Bermuda', 'North Atlantic Pelagic'),
('Emerald Basin', 'Scotian Shelf, Canada'),
('Bay of Fundy', 'Canada'),
('Faial Island', 'Mid-Atlantic Ridge / Azores'),
('Tadoussac', 'St. Lawrence Estuary, Canada'),
('Tarifa', 'Strait of Gibraltar / NE Atlantic'),
('Peninsula Valdes', 'South Atlantic, Patagonia');

-- whales
CREATE TABLE whales (
    whale_id VARCHAR(20) PRIMARY KEY,
    whale_name VARCHAR(50),
    species_name VARCHAR(100) NOT NULL,
    last_location VARCHAR(50),

    FOREIGN KEY (species_name)
        REFERENCES species_name(species_name),

    FOREIGN KEY (last_location)
        REFERENCES locations(location)
);

INSERT INTO whales
(whale_id, whale_name, species_name, last_location)
VALUES
('NARW-4191', 'Dolly', 'North Atlantic right whale (Eubalaena glacialis)', 'Gulf of St. Lawrence'),
('NARW-5299', 'Nibbles', 'North Atlantic right whale (Eubalaena glacialis)', 'Cape Cod Bay'),
('NAHWC-1084', 'Salt', 'Humpback whale (Megaptera novaeangliae)', 'Stellwagen Bank'),
('BMD-0002', 'Candle', 'Humpback whale (Megaptera novaeangliae)', 'South Shore Bermuda'),
('NEFSC-B0412', 'Cobalt', 'Blue whale', 'Emerald Basin'),
('CCS-F0921', 'Streak', 'Fin whale (Balaenoptera physalus)', 'Bay of Fundy'),
('SEAMAP-S308', 'Vesper', 'Sperm whale (Physeter macrocephalus)', 'Faial Island'),
('GREMM-DL144', 'Blanche', 'Beluga whale (Delphinapterus leucas)', 'Tadoussac'),
('GIB-OO019', 'Matriarch', 'Orca / Killer whale (Orcinus orca)', 'Tarifa'),
('SRW-PV774', 'Penelope', 'Southern right whale', 'Peninsula Valdes');

-- sightings
CREATE TABLE sightings (
    sighting_id INT PRIMARY KEY AUTO_INCREMENT,
    sighting_date DATE,
    whale_id VARCHAR(20),
    location VARCHAR(50),

    FOREIGN KEY (whale_id)
        REFERENCES whales(whale_id),

    FOREIGN KEY (location)
        REFERENCES locations(location)
);

INSERT INTO sightings
(sighting_date, whale_id, location)
VALUES
('2026-09-14', 'NARW-4191', 'Gulf of St. Lawrence'),
('2026-04-22', 'NARW-5299', 'Cape Cod Bay'),
('2026-10-08', 'NAHWC-1084', 'Stellwagen Bank'),
('2026-03-30', 'BMD-0002', 'South Shore Bermuda'),
('2026-08-19', 'NEFSC-B0412', 'Emerald Basin'),
('2026-09-27', 'CCS-F0921', 'Bay of Fundy'),
('2026-07-11', 'SEAMAP-S308', 'Faial Island'),
('2026-10-19', 'GREMM-DL144', 'Tadoussac'),
('2026-08-03', 'GIB-OO019', 'Tarifa'),
('2026-10-25', 'SRW-PV774', 'Peninsula Valdes');

SELECT * FROM species_name;
SELECT * FROM locations;
SELECT * FROM whales;
SELECT * FROM sightings;
SHOW TABLES;