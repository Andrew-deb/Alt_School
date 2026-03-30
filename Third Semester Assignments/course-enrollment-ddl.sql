CREATE TYPE user_role AS ENUM ('student', 'admin');

CREATE TABLE 'User' ( -- Note that User is a reserved keyword in SQL, so we need to quote it.
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(200) UNIQUE,
  role user_role NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE Course (
  id SERIAL PRIMARY KEY,
  title VARCHAR(200),
  code VARCHAR(20)
);

CREATE TABLE Enrollment(
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES "User"(id),
  course_id INTEGER REFERENCES Course(id)
);

-- SELECT * FROM "User";
-- SELECT * FROM Course;
-- SELECT * FROM Enrollment;
