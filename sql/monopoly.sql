--
-- This SQL script builds a monopoly database, deleting any pre-existing version.
--
-- @author kvlinden
-- @version Summer, 2015
--
-- Alina Sainju, as86

-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
DROP TABLE IF EXISTS PlayerGame;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS Hotel;
DROP TABLE IF EXISTS PlayerProperty;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS Game;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS LocationOfPiece;

-- Create the schema.
CREATE TABLE Game (
	ID integer PRIMARY KEY,
	time timestamp
	);

CREATE TABLE Player (
	ID integer PRIMARY KEY,
	emailAddress varchar(50) NOT NULL,
	name varchar(50)
	);

CREATE TABLE PlayerGame (
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	score integer
	locationid integer REFERENCES locationofpiece(ID);
	);

CREATE TABLE Property (
	ID integer PRIMARY KEY,
	gameID integer REFERENCES Game(ID),
	playerID integer REFERENCES Player(ID),
	name varchar(50)
);

CREATE TABLE PlayerProperty (
	ID integer PRIMARY KEY,
	playerID integer REFERENCES Player(ID),
	propertyID integer REFERENCES Property(ID)
);

CREATE TABLE House (
	playerpropertyID integer REFERENCES PlayerProperty(ID),
	quantity integer
);

CREATE TABLE Hotel (
	playerpropertyID integer REFERENCES PlayerProperty(ID),
	quantity integer
);

CREATE TABLE LocationOfPiece (
	ID integer PRIMARY KEY
);

-- Allow users to select data from the tables.
GRANT SELECT ON Game TO PUBLIC;
GRANT SELECT ON Player TO PUBLIC;
GRANT SELECT ON PlayerGame TO PUBLIC;
GRANT SELECT ON Property TO PUBLIC;
GRANT SELECT ON PlayerProperty TO PUBLIC;
GRANT SELECT ON House TO PUBLIC;
GRANT SELECT ON Hotel TO PUBLIC;
GRANT SELECT ON LocationOfPiece TO PUBLIC;

-- Add sample records.
INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

INSERT INTO PlayerGame VALUES (1, 1, 0.00);
INSERT INTO PlayerGame VALUES (1, 2, 0.00);
INSERT INTO PlayerGame VALUES (1, 3, 2350.00);
INSERT INTO PlayerGame VALUES (2, 1, 1000.00);
INSERT INTO PlayerGame VALUES (2, 2, 0.00);
INSERT INTO PlayerGame VALUES (2, 3, 500.00);
INSERT INTO PlayerGame VALUES (3, 2, 0.00);
INSERT INTO PlayerGame VALUES (3, 3, 5500.00);

INSERT INTO Property VALUES (1, 1, 1, 'Park City');

INSERT INTO PlayerProperty VALUES (1, 1, 1);

INSERT INTO House VALUES (1, 4);

INSERT INTO Hotel VALUES (1, 2);

INSERT INTO LocationOfPiece VALUES (1);
