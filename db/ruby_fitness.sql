DROP TABLE bookings;
DROP TABLE classes;
DROP TABLE members;


CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR,
  last_name VARCHAR,
  join_date VARCHAR,
  membership_type VARCHAR
);

CREATE TABLE classes (
  id SERIAL PRIMARY KEY,
  name VARCHAR,
  day VARCHAR,
  start_time TIME(0),
  duration VARCHAR,
  max_capacity INT,
  booked_spaces INT DEFAULT 0
);

CREATE TABLE bookings (
  id SERIAL PRIMARY KEY,
  member_id INT REFERENCES members(id) ON DELETE CASCADE,
  class_id INT REFERENCES classes(id) ON DELETE CASCADE
);
