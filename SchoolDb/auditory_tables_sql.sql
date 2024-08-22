CREATE TABLE school_auditory.new_registration(
	register_id INT AUTO_INCREMENT,
    student_name VARCHAR(40),
    major_name VARCHAR(20),
    register_date TIME,
    
    PRIMARY KEY(register_id)
);

CREATE TABLE school_auditory.new_major(
	register_id INT AUTO_INCREMENT,
    major_name VARCHAR(20),
    register_date TIME,
    
    
    PRIMARY KEY(register_id)
);
ALTER TABLE school_auditory.new_major
	ADD message VARCHAR(100) DEFAULT 'new addition';
ALTER TABLE school_auditory.new_registration
	ADD message VARCHAR(100) DEFAULT 'new addition';
    
 CREATE TABLE school_auditory.update_major(
	regis_updt_id INT AUTO_INCREMENT,
    major_id INT,
    message VARCHAR(100),
    
    PRIMARY KEY(regis_updt_id)
    
 );   
CREATE TABLE school_auditory.student_class_registration(
	registration_id INT AUTO_INCREMENT,
    student_name VARCHAR(20),
    class_name VARCHAR(20),
    date_regis TIME,
    
    PRIMARY KEY(registration_id)
    
);

CREATE TABLE school_auditory.student_update(
	update_id INT AUTO_INCREMENT,
    student_id INT,
    message VARCHAR(100),
    update_data TIME,
    
    PRIMARY KEY(update_id, student_id),
    
    FOREIGN KEY(student_id)
		REFERENCES schooldb.student(student_id)
        ON DELETE CASCADE
);
    
    
    
    
    
    
    
    
    