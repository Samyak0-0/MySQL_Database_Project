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

-- Insert sample data
INSERT INTO student VALUES
('S001', 'John Smith'),
('S002', 'Mary Jones'),
('S003', 'Bob Wilson'),
('S004', 'Alice Brown');

INSERT INTO instructor VALUES
('I001', 'Dr. Brown'),
('I002', 'Dr. White'),
('I003', 'Dr. Green'),
('I004', 'Dr. Black');

INSERT INTO course VALUES
('CS101', 'Intro to Computer Science', 3, 'Computer Science', 'I001'),
('CS102', 'Data Structures', 4, 'Computer Science', 'I002'),
('MATH201', 'Calculus I', 4, 'Mathematics', 'I003'),
('PHYS101', 'Physics I', 3, 'Physics', 'I004');

INSERT INTO enrollment VALUES
('S001', 'CS101', 'A', '2024-01-15'),
('S001', 'CS102', 'B+', '2024-01-15'),
('S002', 'CS101', 'A-', '2024-01-15'),
('S003', 'MATH201', 'B', '2024-01-15'),
('S003', 'PHYS101', 'A', '2024-01-15'),
('S004', 'CS101', 'B+', '2024-01-15');

-- Query to reconstruct original data using JOINs
SELECT s.student_id, s.student_name, c.course_id, c.course_name, 
       i.instructor_id, i.instructor_name, e.grade, c.credits, c.department
FROM student s
JOIN enrollment e ON s.student_id = e.student_id
JOIN course c ON e.course_id = c.course_id
JOIN instructor i ON c.instructor_id = i.instructor_id
ORDER BY s.student_id, c.course_id;