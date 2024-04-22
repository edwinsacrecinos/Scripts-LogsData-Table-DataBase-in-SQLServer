-- CREATE TABLE TEST (This comment is redundant as the script itself creates a table named 'moviedata')

-- Connect to the SQL server
USE master;
GO

-- Create the database "movie"
CREATE DATABASE movie;
GO

-- Switch to the context of the database "movie"
USE movie;
GO

-- Create the table "moviedata"
CREATE TABLE moviedata (
idmovie INT IDENTITY(1,1) PRIMARY KEY NOT NULL,  -- Unique identifier for movie (auto-increments)
namemovie VARCHAR(100) NULL,                     -- Movie name (nullable)
typemovie VARCHAR(100) NULL,                     -- Movie genre (nullable)
pricemovie DECIMAL(14,2) NULL,                    -- Movie price (nullable, allows for two decimal places)
statemovie BIT NULL                              -- Movie availability (nullable, 1 likely represents available)
);
GO

-- INSERT DATA
-- Insert data into the moviedata table
INSERT INTO moviedata (namemovie, typemovie, pricemovie, statemovie)
VALUES ('Movie A', 'Love', 10.99, 1),
('Movie B', 'Scare', 8.50, 1),
('Movie C', 'Indie', 12.75, 1);

GO

-- UPDATE DATA
-- Update the price of a movie
UPDATE moviedata
SET pricemovie = 9.99
WHERE namemovie = 'Movie A';
GO

-- DELETE DATA
-- Delete a movie from the moviedata table
DELETE FROM moviedata
WHERE idmovie = 2;
GO

-- Insert additional data into the moviedata table
INSERT INTO moviedata (namemovie, typemovie, pricemovie, statemovie)
VALUES ('Movie D', 'Action', 10.99, 1),
('Movie E', 'Action', 8.50, 1),
('Movie F', 'Action', 12.75, 1);