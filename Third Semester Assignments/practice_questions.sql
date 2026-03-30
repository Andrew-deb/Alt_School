Active: 1774862487403@@108.181.197.152@16420@postgres_db@public@public_db

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    stock INT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    category_id INT REFERENCES categories (id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers (id) ON DELETE CASCADE ON UPDATE CASCADE,
    order_date TIMESTAMPTZ DEFAULT NOW(),
    status VARCHAR(50) DEFAULT 'pending'
);

CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders (id) ON DELETE CASCADE ON UPDATE CASCADE,
    product_id INT REFERENCES products (id) ON DELETE CASCADE ON UPDATE CASCADE,
    quantity INT,
    price DECIMAL(10, 2) -- Snapshot of product price
);

-- Insert customers
INSERT INTO
    customers (name, email)
VALUES (
        'Alice Johnson',
        'alice@example.com'
    ),
    (
        'Bob Smith',
        'bob@example.com'
    ),
    (
        'Tunde Bright',
        'tunde@example.com'
    );

-- Insert products
INSERT INTO
    products (
        name,
        description,
        price,
        stock,
        category_id
    )
VALUES (
        'Laptop',
        '15 inch display',
        999.99,
        10,
        1
    ),
    (
        'Headphones',
        'Noise cancelling',
        199.99,
        30,
        1
    ),
    (
        'Coffee Mug',
        'Ceramic 300ml',
        9.99,
        100,
        2
    );

-- Insert orders
INSERT INTO orders (customer_id) VALUES (1), (2);

-- Insert order items
INSERT INTO
    order_items (
        order_id,
        product_id,
        quantity,
        price
    )
VALUES (1, 4, 1, 999.99),
    (1, 6, 2, 9.99),
    (2, 5, 1, 199.99);

INSERT INTO
    categories (name)
VALUES ('Electronics'),
    ('Home & Kitchen')

-- UPDATE products
-- SET id= CASE
--     WHEN id = 4 THEN 1
--     WHEN id = 5 THEN 2
--     WHEN id = 6 THEN 3
-- END
-- WHERE id IN (4, 5, 6)

-- Practice questions
-- 1. List all customers who placed orders containing a product with "Laptop" in the name.

SELECT DISTINCT
    c.id,
    c.name,
    c.email
FROM
    customers c
    JOIN orders o ON c.id = o.customer_id
    JOIN order_items oi ON o.id = oi.order_id
    JOIN products p ON oi.product_id = p.id
WHERE
    p.name LIKE '%Laptop%';

-- 2. Get all products in the "Cosmetics" category (assume category name = "Cosmetics").

SELECT *
FROM products p
    JOIN categories c ON p.category_id = c.id
WHERE
    c.name = 'Cosmetics';

--3. Show all orders along with total quantity of items for each.
SELECT o.id, o.customer_id, o.order_date, o.status, i.quantity
FROM orders o
    JOIN order_items i ON i.order_id = o.id;

--4. Find customers whose name starts with "A".
SELECT * FROM customers WHERE name LIKE 'A%';

--5. List all products with stock less than 10 and name containing "USB".
SELECT * FROM products WHERE stock < 10 AND name LIKE '%USB%'