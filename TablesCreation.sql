CREATE SCHEMA orders;

DROP SCHEMA orders;

	CREATE TABLE clients (
		client_id INT AUTO_INCREMENT,
		first_name VARCHAR(20),
		last_name VARCHAR(20),
		birth DATE,
		sex VARCHAR(1),
		main_address_id INT,
		
		PRIMARY KEY(client_id)
	);
DROP TABLE clients;
	

CREATE TABLE address(
	address_id INT AUTO_INCREMENT,
	client_id INT,
	street VARCHAR(40),
	complement VARCHAR(40),
	city VARCHAR(20),
	
	PRIMARY KEY(address_id),
	FOREIGN KEY(client_id) 
	REFERENCES clients(client_id)
	ON DELETE CASCADE
);
    
    DROP TABLE address;
    
    ALTER TABLE clients
		ADD FOREIGN KEY(main_address_id)
		REFERENCES address(address_id)
		ON DELETE SET NULL;
    
CREATE TABLE category(
	category_id INT AUTO_INCREMENT,
    name VARCHAR(20),
    
    PRIMARY KEY(category_id)
);

CREATE TABLE products(
	product_id INT AUTO_INCREMENT,
    product_name VARCHAR(20),
    price DECIMAL(12,2),
    category_id INT,
    
    PRIMARY KEY(product_id),
    FOREIGN KEY(category_id)
    REFERENCES category(category_id)
    ON DELETE SET NULL
);
DROP TABLE products;
ALTER TABLE products
	DROP price;
    
ALTER TABLE products
	ADD price DECIMAL(12,2);

INSERT INTO clients(first_name,last_name,birth,sex)
VALUES
('João', 'Silva', '1970-10-05', 'M'),
('Maria', 'Oliveira', '1990-11-25', 'F'),
('Carlos', 'Pereira', '1975-12-01', 'M'),
('Ana', 'Costa', '1988-07-29', 'F'),
('Lucas', 'Fernandes', '1995-03-12', 'M'),
('Juliana', 'Martins', '1983-11-04', 'F');

SELECT * FROM clients;

INSERT INTO address(client_id, street, complement, city)
VALUES
(1, 'Rua das flores', 'Apto 101', 'São Paulo'),
(1, 'Travessa Ipê', 'Última rua', 'São Leopoldo'),
(2, 'Avenida Paulista', 'Sala 200', 'São Paulo'),
(3, 'Rua dos jardins', 'Casa 3', 'Campinas'),
(3, 'Rua Boston', 'Perto da maior árvore', 'Novo Hamburgo'),
(4, 'Rua dos pinheiros', 'Bloco A, apto 205', 'São Paulo'),
(5, 'Rua da consolação', 'Casa 15', 'São Paulo'),
(6, 'Avenida São João', 'Cobertura 3', 'São Paulo');

INSERT INTO products(product_name, price, category_id)
VALUES
('Tênis nike shocks', 230.99,1),
('Boné de corrida', 20.99,1),
('Camisa polo', 30.99, 3),
('Saia', 14.99,3),
('Carne porco', 10.99,2);

INSERT INTO category(name)
VALUES 
('Esportes'), ('Comida'), ('Roupa');

CREATE TABLE buyorder(
	order_id INT AUTO_INCREMENT,
    client_id INT,
    address_id INT,
    is_finished BOOLEAN,
    total_value DECIMAL(12,2),
    
    PRIMARY KEY(order_id, client_id),
    
    FOREIGN KEY(client_id)
		REFERENCES clients(client_id)
		ON DELETE CASCADE,
    FOREIGN KEY(address_id)
		REFERENCES address(address_id)
        ON DELETE SET NULL
);
DROP TABLE buy_order;
ALTER TABLE buy_order
	ADD total_value DECIMAL(12,2);

CREATE TABLE itemorder(
	item_id INT AUTO_INCREMENT,
    product_id INT,
    order_id INT,
    client_id INT,
	value DECIMAL(12,2),
    
    PRIMARY KEY(item_id, product_id, order_id),
    
    FOREIGN KEY(product_id)
		REFERENCES products(product_id)
		ON DELETE CASCADE,
	FOREIGN KEY(order_id, client_id)
		REFERENCES buyorder(order_id, client_id)
		ON DELETE CASCADE
);
DROP TABLE buy_order;
DROP TABLE itemorder;














    
    
    