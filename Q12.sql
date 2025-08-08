-- Create the normalized tables from our BCNF design
CREATE TABLE student (
    student_id VARCHAR(10) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

CREATE TABLE instructor (
    instructor_id VARCHAR(10) PRIMARY KEY,
    instructor_name VARCHAR(100) NOT NULL
);

CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department VARCHAR(50) NOT NULL,
    instructor_id VARCHAR(10),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);

CREATE TABLE enrollment (
    student_id VARCHAR(10),
    course_id VARCHAR(10),
    grade VARCHAR(5),
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

-- Insert modified sample data
INSERT INTO student VALUES
('S101', 'Emma Davis'),
('S102', 'Liam Johnson'),
('S103', 'Olivia Taylor'),
('S104', 'Noah Martinez');

INSERT INTO instructor VALUES
('I101', 'Prof. Adams'),
('I102', 'Prof. Clark'),
('I103', 'Prof. Lewis'),
('I104', 'Prof. Walker');

INSERT INTO course VALUES
('CS201', 'Programming Fundamentals', 3, 'Computer Science', 'I101'),
('CS202', 'Algorithms', 4, 'Computer Science', 'I102'),
('MATH301', 'Linear Algebra', 4, 'Mathematics', 'I103'),
('CHEM101', 'General Chemistry', 3, 'Chemistry', 'I104');

INSERT INTO enrollment VALUES
('S101', 'CS201', 'A+', '2025-01-20'),
('S101', 'CS202', 'B', '2025-01-20'),
('S102', 'CS201', 'A', '2025-01-20'),
('S103', 'MATH301', 'B+', '2025-01-20'),
('S103', 'CHEM101', 'A-', '2025-01-20'),
('S104', 'CS201', 'B', '2025-01-20');

-- Query to reconstruct original data using JOINs
SELECT s.student_id, s.student_name, c.course_id, c.course_name, 
       i.instructor_id, i.instructor_name, e.grade, c.credits, c.department
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course c ON e.course_id = c.course_id
JOIN instructor i ON c.instructor_id = i.instructor_id
ORDER BY s.student_id, c.course_id;