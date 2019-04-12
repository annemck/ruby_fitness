DROP TABLE bookings;
DROP TABLE classes;
DROP TABLE members;
DROP TABLE images;


CREATE TABLE members (
  id INT PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  join_date VARCHAR,
  membership_type VARCHAR
);

CREATE TABLE classes (
  id INT PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE bookings (
  id INT PRIMARY KEY,
  member_id INT REFERENCES members(id),
  class_id INT REFERENCES classes(id)
);

CREATE TABLE images (
  id INT PRIMARY KEY,
  link VARCHAR
);
