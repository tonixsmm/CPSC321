
/**********************************************************************
 * NAME: Tony Nguyen
 * CLASS: CPSC 321 01
 * DATE: 10/03/2023
 * HOMEWORK: 3
 * DESCRIPTION: This SQL code exercises the requirements of HW3.
 * OBSERVATION: I don't have any challenges with this assignment.
 **********************************************************************/


-- Drop table statements
DROP TABLE IF EXISTS GroupAndArtist;
DROP TABLE IF EXISTS GroupAndGenre;
DROP TABLE IF EXISTS AlbumAndTrack;
DROP TABLE IF EXISTS GroupAndInfluencer;
DROP TABLE IF EXISTS SongAndArtist;
DROP TABLE IF EXISTS Song;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS MusicGroup;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS RecordLabel;


-- Create table statements
CREATE TABLE Artist (
    name VARCHAR(50),
    birth_year YEAR,
    PRIMARY KEY (name)
);


CREATE TABLE Genre (
    name VARCHAR(50),
    description VARCHAR(255),
    PRIMARY KEY (name)
    -- UNIQUE description
);


CREATE TABLE Track (
    year YEAR,
    name INT UNSIGNED,
    PRIMARY KEY (name)
);


CREATE TABLE RecordLabel (
    name VARCHAR(50),
    PRIMARY KEY (name)
);


CREATE TABLE MusicGroup (
    name VARCHAR(50),
    year_formed YEAR,
    PRIMARY KEY (name)
);


CREATE TABLE Album (
    title VARCHAR(50),
    year YEAR,
    group_name VARCHAR(50),
    record_label VARCHAR(50),
    PRIMARY KEY (title, group_name),
    FOREIGN KEY (group_name) REFERENCES MusicGroup(name),
    FOREIGN KEY (record_label) REFERENCES RecordLabel(name)
);


CREATE TABLE Song (
    song_title VARCHAR(50),
    year YEAR,
    track_id INT UNSIGNED,
    PRIMARY KEY (song_title),
    FOREIGN KEY (track_id) REFERENCES Track(name),
    UNIQUE (track_id)
);


CREATE TABLE SongAndArtist (
    song_title VARCHAR(50),
    artist_name VARCHAR(50),
    PRIMARY KEY (song_title, artist_name),
    FOREIGN KEY (song_title) REFERENCES Song(song_title),
    FOREIGN KEY (artist_name) REFERENCES Artist(name)
);


CREATE TABLE GroupAndInfluencer (
    group_name VARCHAR(50),
    influenced_by VARCHAR(50),
    PRIMARY KEY (group_name, influenced_by),
    FOREIGN KEY (group_name) REFERENCES MusicGroup(name),
    FOREIGN KEY (influenced_by) REFERENCES MusicGroup(name)
);


CREATE TABLE AlbumAndTrack (
    album_title VARCHAR(50),
    track_id INT UNSIGNED,
    group_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (album_title, track_id),
    FOREIGN KEY (album_title) REFERENCES Album(title),
    FOREIGN KEY (track_id) REFERENCES Track(name),
    FOREIGN KEY (group_name) REFERENCES MusicGroup(name)
);


CREATE TABLE GroupAndGenre (
    group_name VARCHAR(50),
    genre_label VARCHAR(50),
    PRIMARY KEY (group_name, genre_label),
    FOREIGN KEY (group_name) REFERENCES MusicGroup(name),
    FOREIGN KEY (genre_label) REFERENCES Genre(name)
);


CREATE TABLE GroupAndArtist (
    artist_name VARCHAR(50),
    group_name VARCHAR(50),
    start_year YEAR,
    end_year YEAR,
    PRIMARY KEY (artist_name, group_name, start_year),
    FOREIGN KEY (artist_name) REFERENCES Artist(name),
    FOREIGN KEY (group_name) REFERENCES MusicGroup(name)
);


-- Add insert statements
INSERT INTO Artist VALUES
    ('Taylor Swift', 1989),
    ('Phobe Bridgers', 1994),
    ('Conan Gray', 1998),
    ('Olivia Rodrigo', 2003),
    ('Chris Martin', 1977),
    ('Jonny Buckland', 1977),
    ('Guy Berryman', 1978),
    ('Will Champion', 1978),
    ('Phil Harvey', 1976),
    ('Tim McGraw', 1967);


INSERT INTO Genre VALUES
    ('Pop', 'Popular music'),
    ('Indie', 'Independent music'),
    ('Alternative', 'Alternative music'),
    ('Rock', 'Rock music'),
    ('Country', 'Country music');


INSERT INTO Track VALUES
    (2020, 1),
    (2020, 2),
    (2020, 3),
    (2020, 4),
    (2020, 5),
    (2020, 6),
    (2020, 7),
    (2020, 8),
    (2020, 9),
    (2020, 10),
    (2020, 11),
    (2020, 12),
    (2020, 13),
    (2020, 14),
    (2020, 15),
    (2020, 16),
    (2020, 17),
    (2023, 18),
    (2023, 19),
    (2023, 20),
    (2023, 21),
    (2023, 22),
    (2023, 23),
    (2023, 24),
    (2023, 25),
    (2023, 26),
    (2000, 27),
    (2000, 28),
    (2000, 29),
    (2000, 30),
    (2000, 31),
    (2000, 32),
    (2000, 33),
    (2000, 34),
    (2000, 35);


INSERT INTO RecordLabel VALUES
    ('Republic Records'),
    ('Interscope Records'),
    ('Capitol Records'),
    ('Atlantic Records'),
    ('Geffen Records');


INSERT INTO MusicGroup VALUES
    ('Taylor Swift', 2006),
    ('Phoebe Bridgers', 2014),
    ('Conan Gray', 2013),
    ('Olivia Rodrigo', 2015),
    ('Coldplay', 1997),
    ('Tim McGraw', 1990);


INSERT INTO Album VALUES
    ('folklore', 2020, 'Taylor Swift', 'Republic Records'),
    ('evermore', 2020, 'Taylor Swift', 'Republic Records'),
    ('GUTS', 2023, 'Olivia Rodrigo', 'Geffen Records'),
    ("Speak Now (Taylor's Version)", 2023, 'Taylor Swift', 'Republic Records'),
    ('Sour', 2021, 'Olivia Rodrigo', 'Geffen Records'),
    ('Parachutes', 2000, 'Coldplay', 'Capitol Records'),
    ('A Rush of Blood to the Head', 2002, 'Coldplay', 'Capitol Records'),
    ('X&Y', 2005, 'Coldplay', 'Capitol Records'),
    ('Viva la Vida or Death and All His Friends', 2008, 'Coldplay', 'Capitol Records'),
    ('Mylo Xyloto', 2011, 'Coldplay', 'Capitol Records'),
    ('Ghost Stories', 2014, 'Coldplay', 'Capitol Records'),
    ('A Head Full of Dreams', 2015, 'Coldplay', 'Capitol Records'),
    ('Everyday Life', 2019, 'Coldplay', 'Capitol Records'),
    ('Music of the Spheres', 2021, 'Coldplay', 'Capitol Records');


INSERT INTO Song VALUES
    ('willow', 2020, 1),
    ('champagne problems', 2020, 2),
    ('gold rush', 2020, 3),
    ('tis the damn season', 2020, 4),
    ('tolerate it', 2020, 5),
    ('no body, no crime', 2020, 6),
    ('happiness', 2020, 7),
    ('dorothea', 2020, 8),
    ('coney island', 2020, 9),
    ('ivy', 2020, 10),
    ('cowboy like me', 2020, 11),
    ('long story short', 2020, 12),
    ('marjorie', 2020, 13),
    ('closure', 2020, 14),
    ('evermore', 2020, 15),
    ('right where you left me', 2020, 16),
    ('it’s time to go', 2020, 17),
    ('Yellow', 2000, 27),
    ('Trouble', 2000, 28),
    ('Shiver', 2000, 29),
    ('Sparks', 2000, 30),
    ('Parachutes', 2000, 31),
    ('High Speed', 2000, 32),
    ('We Never Change', 2000, 33),
    ('Everything’s Not Lost', 2000, 34),
    ('vampire', 2023, 18),
    ('teenage dream', 2023, 19),
    ('bad idea right?', 2023, 20),
    ('ballad of the homeschooled girl', 2023, 21),
    ('logical', 2023, 22);


INSERT INTO SongAndArtist VALUES
    ('willow', 'Taylor Swift'),
    ('champagne problems', 'Taylor Swift'),
    ('gold rush', 'Taylor Swift'),
    ('tis the damn season', 'Taylor Swift'),
    ('tolerate it', 'Taylor Swift'),
    ('no body, no crime', 'Taylor Swift'),
    ('happiness', 'Taylor Swift'),
    ('dorothea', 'Taylor Swift'),
    ('coney island', 'Taylor Swift'),
    ('ivy', 'Taylor Swift'),
    ('cowboy like me', 'Taylor Swift'),
    ('long story short', 'Taylor Swift'),
    ('marjorie', 'Taylor Swift'),
    ('closure', 'Taylor Swift'),
    ('evermore', 'Taylor Swift'),
    ('right where you left me', 'Taylor Swift'),
    ("it’s time to go", 'Taylor Swift'),
    ('Yellow', 'Chris Martin'),
    ('Yellow', 'Jonny Buckland'),
    ('Yellow', 'Guy Berryman'),
    ('Yellow', 'Will Champion'),
    ('Yellow', 'Phil Harvey'),
    ('Trouble', 'Chris Martin'),
    ('Trouble', 'Jonny Buckland'),
    ('Trouble', 'Guy Berryman'),
    ('Trouble', 'Will Champion'),
    ('Trouble', 'Phil Harvey'),
    ('Shiver', 'Chris Martin'),
    ('Shiver', 'Jonny Buckland'),
    ('Shiver', 'Guy Berryman'),
    ('Shiver', 'Will Champion'),
    ('Shiver', 'Phil Harvey'),
    ('Sparks', 'Chris Martin'),
    ('Sparks', 'Jonny Buckland'),
    ('Sparks', 'Guy Berryman'),
    ('Sparks', 'Will Champion'),
    ('Sparks', 'Phil Harvey'),
    ('Parachutes', 'Chris Martin'),
    ('Parachutes', 'Jonny Buckland'),
    ('Parachutes', 'Guy Berryman'),
    ('Parachutes', 'Will Champion'),
    ('Parachutes', 'Phil Harvey'),
    ('High Speed', 'Chris Martin'),
    ('High Speed', 'Jonny Buckland'),
    ('High Speed', 'Guy Berryman'),
    ('High Speed', 'Will Champion'),
    ('High Speed', 'Phil Harvey'),
    ('We Never Change', 'Chris Martin'),
    ('We Never Change', 'Jonny Buckland'),
    ('We Never Change', 'Guy Berryman'),
    ('We Never Change', 'Will Champion'),
    ('We Never Change', 'Phil Harvey'),
    ('Everything’s Not Lost', 'Chris Martin'),
    ('Everything’s Not Lost', 'Jonny Buckland'),
    ('Everything’s Not Lost', 'Guy Berryman'),
    ('Everything’s Not Lost', 'Will Champion'),
    ('Everything’s Not Lost', 'Phil Harvey'),
    ('vampire', 'Olivia Rodrigo'),
    ('teenage dream', 'Olivia Rodrigo'),
    ('bad idea right?', 'Olivia Rodrigo'),
    ('ballad of the homeschooled girl', 'Olivia Rodrigo'),
    ('logical', 'Olivia Rodrigo');


INSERT INTO GroupAndInfluencer VALUES
    ('Taylor Swift', 'Tim McGraw'),
    ('Olivia Rodrigo', 'Taylor Swift'),
    ('Conan Gray', 'Taylor Swift');


INSERT INTO AlbumAndTrack VALUES
    ('evermore', 1, 'Taylor Swift'),
    ('evermore', 2, 'Taylor Swift'),
    ('evermore', 3, 'Taylor Swift'),
    ('evermore', 4, 'Taylor Swift'),
    ('evermore', 5, 'Taylor Swift'),
    ('evermore', 6, 'Taylor Swift'),
    ('evermore', 7, 'Taylor Swift'),
    ('evermore', 8, 'Taylor Swift'),
    ('evermore', 9, 'Taylor Swift'),
    ('evermore', 10, 'Taylor Swift'),
    ('evermore', 11, 'Taylor Swift'),
    ('evermore', 12, 'Taylor Swift'),
    ('evermore', 13, 'Taylor Swift'),
    ('evermore', 14, 'Taylor Swift'),
    ('evermore', 15, 'Taylor Swift'),
    ('evermore', 16, 'Taylor Swift'),
    ('evermore', 17, 'Taylor Swift'),
    ('Parachutes', 1, 'Coldplay'),
    ('Parachutes', 2, 'Coldplay'),
    ('Parachutes', 3, 'Coldplay'),
    ('Parachutes', 4, 'Coldplay'),
    ('Parachutes', 5, 'Coldplay'),
    ('Parachutes', 6, 'Coldplay'),
    ('Parachutes', 7, 'Coldplay'),
    ('GUTS', 1, 'Olivia Rodrigo'),
    ('GUTS', 2, 'Olivia Rodrigo'),
    ('GUTS', 3, 'Olivia Rodrigo'),
    ('GUTS', 4, 'Olivia Rodrigo'),
    ('GUTS', 5, 'Olivia Rodrigo');


INSERT INTO GroupAndGenre VALUES
    ('Taylor Swift', 'Pop'),
    ('Taylor Swift', 'Country'),
    ('Olivia Rodrigo', 'Pop'),
    ('Olivia Rodrigo', 'Alternative'),
    ('Olivia Rodrigo', 'Indie'),
    ('Coldplay', 'Alternative'),
    ('Coldplay', 'Rock');


INSERT INTO GroupAndArtist VALUES
    ('Chris Martin', 'Coldplay', 1997, NULL),
    ('Jonny Buckland', 'Coldplay', 1997, NULL),
    ('Guy Berryman', 'Coldplay', 1997, NULL),
    ('Will Champion', 'Coldplay', 1997, NULL),
    ('Phil Harvey', 'Coldplay', 1997, NULL),
    ('Taylor Swift', 'Taylor Swift', 2008, NULL),
    ('Olivia Rodrigo', 'Olivia Rodrigo', 2015, NULL),
    ('Conan Gray', 'Conan Gray', 2013, NULL);

