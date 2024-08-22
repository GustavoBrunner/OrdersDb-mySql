INSERT INTO schooldb.major(major_name)
VALUES('Biology');

INSERT INTO schooldb.major(major_name)
VALUES('Computer Science');

INSERT INTO schooldb.major(major_name)
VALUES('Mathematic');

UPDATE schooldb.major
	SET major.major_name = 'Medicine'
	WHERE major.major_id = 1;
    
INSERT INTO schooldb.student(major_id,f_name,l_name,phone,email,start_date)
VALUES(1, 'Gustavo', 'Brunner', '999999999', 'teste@email.com', NOW());

INSERT INTO schooldb.student(major_id,f_name,l_name,phone,email,start_date)
VALUES(3, 'Alberto', 'Silva', '999999999', 'teste@email.com', NOW());

INSERT INTO schooldb.class(class.class_name, class.major_id)
VALUES('Anatomia', 1);
INSERT INTO schooldb.class(class.class_name, class.major_id)
VALUES('Anatomia 2', 1);

INSERT INTO schooldb.class(class.class_name, class.major_id)
VALUES('Anatomia esporte', 1);

UPDATE schooldb.class
SET price = 450
WHERE class.class_id = 9;

DELETE FROM schooldb.student
WHERE schooldb.student.student_id = 1;

INSERT INTO student_class_taken(student_id, class_id, major_id, price)
VALUES(3, 1, 1, 350.90);



    
    
    
    