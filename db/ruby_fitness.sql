DROP TABLE bookings;
DROP TABLE classes;
DROP TABLE members;
DROP TABLE images;


CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  join_date VARCHAR,
  membership_type VARCHAR
);

CREATE TABLE classes (
  id SERIAL PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  class_id INT REFERENCES classes(id) ON DELETE CASCADE
);

CREATE TABLE images (
  id SERIAL PRIMARY KEY,
  link VARCHAR
);
