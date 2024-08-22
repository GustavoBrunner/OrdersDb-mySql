DELIMITER $$
CREATE
	TRIGGER on_add_new_student
		AFTER INSERT
        ON schooldb.student
			FOR EACH ROW
			BEGIN
				INSERT INTO school_auditory.new_registration(student_name, major_name, register_date, message)
                VALUES (CONCAT(NEW.f_name + ' ', NEW.l_name),
					(SELECT schooldb.major.major_name
						FROM schooldb.major
                        WHERE schooldb.major.major_id = NEW.major_id),
					NOW(), 'New student registry added!');
			END$$ 
DELIMITER ;    
DROP TRIGGER  on_add_new_student;
DROP TRIGGER  on_add_new_major;

DELIMITER $$

CREATE
	TRIGGER on_add_new_major
		AFTER INSERT 
        ON schooldb.major
			FOR EACH ROW
				BEGIN
					INSERT INTO school_auditory.new_major(major_name, register_date, message)
					VALUES(NEW.major_name, NOW(), 'New major added');
                END $$
DELIMITER ;

DELIMITER $$

CREATE
	TRIGGER on_update_major
		AFTER UPDATE
        ON schooldb.major
			FOR EACH ROW
				BEGIN
					INSERT INTO school_auditory.update_major(major_id, message)
                    VALUES(NEW.major_id, 'Major updated!');
                END $$
DELIMITER ;
    
DELIMITER $$

CREATE 
	TRIGGER on_student_class_register
		AFTER INSERT 
			ON schooldb.student_class_taken
            FOR EACH ROW
				BEGIN
					UPDATE schooldb.student
                    SET schooldb.student.mensality = (
						SELECT SUM(schooldb.student_class_taken.price)
						FROM schooldb.student_class_taken
						WHERE schooldb.student_class_taken.student_id = NEW.student_id)
					WHERE schooldb.student.student_id = NEW.student_id;
                END $$
DELIMITER ;    
DROP TRIGGER on_student_class_register;

DROP TRIGGER on_student_class_register;

DELIMITER $$
 CREATE
	TRIGGER on_student_updated
		AFTER UPDATE
			ON schooldb.student_class_taken
				FOR EACH ROW
					BEGIN
						INSERT INTO school_auditory.student_class_registration(student_name, class_name, date_regis)
                        VALUES((
							SELECT CONCAT(schooldb.student.f_name,schooldb.student.l_name)
                            FROM schooldb.student
							WHERE schooldb.student.student_id = NEW.student_id), 
								(
								SELECT schooldb.class.class_name
								FROM schooldb.class
								WHERE schooldb.class.class_id = NEW.class_id), 
							NOW()
                            );
                    END$$
DELIMITER ;
    
DELIMITER $$
CREATE 
	TRIGGER on_student_updated
		AFTER UPDATE
			ON schooldb.student
				FOR EACH ROW
					BEGIN
						INSERT INTO school_auditory.student_update(student_id, message, update_data)
                        VALUES(NEW.student_id, 'Student updated!', NOW());
                    END $$
DELIMITER ;
    
DROP TRIGGER on_student_updated;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    