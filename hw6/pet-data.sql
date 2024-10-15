DROP TABLE IF EXISTS pet;

CREATE TABLE pet (
  id INT UNSIGNED,
  name TINYTEXT NOT NULL,
  type TINYTEXT NOT NULL,
  PRIMARY KEY (id)
);

INSERT INTO pet VALUES
  (1, 'fido', 'dog'),
  (2, 'bill', 'cat'),
  (3, 'hobbes', 'tiger'),
  (4, 'toto', 'dog'),
  (5, 'babe', 'pig'),
  (6, 'hola', 'dog'),
  (7, 'milo', 'cat'),
  (8, 'luna', 'tiger'),
  (9, 'bella', 'pig'),
  (10, 'lola', 'turtle'),
  (11, 'meredith', 'bird'),
  (12, 'olivia', 'bird'),
  (13, 'ben', 'turtle'),
  (14, 'lucy', 'dinasour'),
  (15, 'charlie', 'dinasour');

