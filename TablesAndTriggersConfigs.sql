SELECT clients.first_name, clients.last_name, address.city, address.complement
FROM clients
INNER JOIN address
ON clients.client_id = address.client_id
ORDER BY clients.first_name, clients.last_name;

SELECT clients.first_name, clients.last_name, address.street
FROM clients
INNER JOIN address
WHERE clients.client_id IN (
	SELECT address.client_id 
	FROM address
	WHERE address.city = 'São Paulo'
) 
AND clients.client_id = address.client_id;


SELECT products.product_name, category.name, products.price, products.stock
FROM products
INNER JOIN category
WHERE products.category_id IN (
	SELECT category.category_id
    FROM category
)
AND products.category_id = category.category_id
AND products.price > 30;


DELIMITER $$

CREATE PROCEDURE add_new_category(name VARCHAR(20))
BEGIN
	INSERT INTO category(name)
    VALUES(name);
END $$
DELIMITER ;

CALL add_new_category('Vegetais');
SELECT * FROM category;

CREATE TABLE inserts_category_audition(
	insert_id INT AUTO_INCREMENT,
    category_id INT,
    insert_date DATE,
    
    PRIMARY KEY(insert_id, category_id),
    FOREIGN KEY(category_id) 
    REFERENCES category(category_id)
    ON DELETE CASCADE
    
);
DELIMITER $$
CREATE 
	TRIGGER on_insert_category
		AFTER INSERT 
		ON category
        FOR EACH ROW BEGIN
			INSERT INTO inserts_category_audition(category_id, insert_date) 
				VALUES(NEW.category_id, NOW());
	END $$
DELIMITER ;

CALL add_new_category('Brinquedos');
SELECT * FROM inserts_category_audition;

SELECT inserts_category_audition.insert_date, category.name 
FROM inserts_category_audition
INNER JOIN category
WHERE inserts_category_audition.category_id IN (
	SELECT category.category_id 
    FROM category
)
AND inserts_category_audition.category_id = category.category_id;

SELECT * FROM inserts_category_audition;

DELIMITER $$

CREATE 
	PROCEDURE add_item_order(product_id INT, order_id INT, client_id INT, value)

END $$

DELIMITER ;

DELIMITER $$

CREATE
	TRIGGER on_new_itemorder_added
		AFTER INSERT ON itemorder
        FOR EACH ROW 
			BEGIN
				UPDATE buyorder
                SET buyorder.total_value = (
					SELECT SUM(itemorder.price)
                    FROM itemorder
                    WHERE itemorder.order_id = buyorder.order_id
                )
                WHERE buyorder.order_id = NEW.order_id;
			END $$

DELIMITER ;

DROP TRIGGER on_new_itemorder_added;

ALTER TABLE buyorder
	ADD total_value DECIMAL(12,2) DEFAULT 0;

INSERT INTO buyorder(client_id, address_id, is_finished)
VALUES(1,1, FALSE);
ALTER TABLE itemorder
	ADD price DECIMAL(12,2) DEFAULT 0;
    
    
    
INSERT INTO itemorder(product_id, order_id, client_id, price)
VALUES 
(1,1,1, 230.99),
(1,1,1, 230.99),
(2,1,1, 20.99);

INSERT INTO itemorder(product_id, order_id, client_id, price)
VALUES 
(1,1,1, 230.99);

DELIMITER $$

CREATE
	TRIGGER on_product_sell
    AFTER INSERT ON itemorder
		FOR EACH ROW
			BEGIN 
				UPDATE products
                SET products.stock = products.stock - 1
                WHERE products.product_id = NEW.product_id;
			END $$

DELIMITER ;

DELIMITER $$

CREATE 
	TRIGGER on_buyorder_created
    AFTER INSERT ON buyorder
		FOR EACH ROW
			BEGIN
				INSERT INTO buyorder_created(creation_date, order_id, client_id)
                VALUES(NOW(), NEW.order_id, NEW.client_id);
            END $$

DELIMITER ;

CREATE TABLE buyorder_created(
	creation_id INT AUTO_INCREMENT,
    creation_date DATE,
    order_id INT,
    client_id INT,
    
    PRIMARY KEY(creation_id, order_id),
    FOREIGN KEY(order_id, client_id)
    REFERENCES buyorder(order_id, client_id)
    ON DELETE CASCADE
);


DROP TRIGGER on_product_sell;

INSERT INTO itemorder(product_id, order_id, client_id, price)
VALUES 
(2,1,1, 20.99);

INSERT INTO buyorder(client_id, address_id, is_finished)
VALUES(2,2,FALSE);

INSERT INTO itemorder(product_id, order_id, client_id, price)
VALUES 
(2,2,2, 20.99);









