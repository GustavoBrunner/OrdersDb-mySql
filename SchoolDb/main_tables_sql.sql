CREATE SCHEMA schooldb;

CREATE TABLE student(
	student_id INT AUTO_INCREMENT,
    major_id INT,
    f_name VARCHAR(20),
    l_name VARCHAR(20),
    mensality DECIMAL(12,2),
    phone VARCHAR(9),
    email VARCHAR(100),
    start_date TIME,
    
    PRIMARY KEY(student_id)
    
    
    
);
ALTER TABLE schooldb.student
	DROP  club_id;
    
CREATE TABLE student_class_taken(
	registration_id INT AUTO_INCREMENT,
	student_id INT,
    class_id INT,
    major_id INT,
    
    PRIMARY KEY(registration_id, student_id, class_id),
    
    FOREIGN KEY(student_id)
		REFERENCES student(student_id)
		ON DELETE CASCADE,
    FOREIGN KEY(class_id, major_id) 
		REFERENCES class(class_id, major_id)
        ON DELETE CASCADE
);
ALTER TABLE student_class_taken
	ADD price DECIMAL(12,2);

ALTER TABLE student
	ADD FOREIGN KEY(major_id)
	REFERENCES major(major_id)
    ON DELETE SET NULL;


CREATE TABLE club(
	club_id INT AUTO_INCREMENT,
    club_name VARCHAR(40),
    
    PRIMARY KEY(club_id)
);

CREATE TABLE teacher(
	teacher_id INT AUTO_INCREMENT,
    salary DECIMAL(12,2),
    teacher_f_name VARCHAR(20),
    teacher_l_name VARCHAR(20),
    email VARCHAR(100),
    phone VARCHAR(9),
    
    PRIMARY KEY(teacher_id)

);

CREATE TABLE class(
	class_id INT AUTO_INCREMENT,
    major_id INT,
    teacher_id INT,
    class_name VARCHAR(30),
    
    
    PRIMARY KEY(class_id, major_id)
);
ALTER TABLE class
	ADD price DECIMAL(12,2);
DROP TABLE class;
DROP TABLE student;
DROP TABLE student_class_taken;
ALTER TABLE class
	ADD FOREIGN KEY(major_id)
    REFERENCES major(major_id);
ALTER TABLE class
	ADD FOREIGN KEY(teacher_id)
    REFERENCES teacher(teacher_id)
    ON DELETE SET NULL;
    

CREATE TABLE major(
	major_id INT AUTO_INCREMENT,
    major_name VARCHAR(20),
    
    PRIMARY KEY(major_id)
);


CREATE TABLE student_is_part_club(
	student_id INT,
    club_id INT,
    club_name VARCHAR(30),
    student_name VARCHAR(20),
    register_moment TIME,
    
    PRIMARY KEY(student_id, club_id),
    FOREIGN KEY(student_id)
		REFERENCES student(student_id)
        ON DELETE CASCADE,
	FOREIGN KEY(club_id)
		REFERENCES club(club_id)
        ON DELETE CASCADE
);










