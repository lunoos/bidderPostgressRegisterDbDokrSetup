CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE vendors (
    vendor_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    vendor_name VARCHAR(100) NOT NULL,
    vendor_description VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    vendor_id INTEGER NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_description VARCHAR(500),
    category_code VARCHAR(50),
    category_name VARCHAR(100),
    product_url VARCHAR(500),
    base_price NUMERIC(9,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

CREATE TABLE auction_slot (
    slot_id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    slot_name VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    slot_section INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE config (
    config_id SERIAL PRIMARY KEY,
    config_name VARCHAR(100) NOT NULL,
    config_code VARCHAR(50) NOT NULL,
    config_desc VARCHAR(500),
    config_value VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO config (config_name, config_code, config_value) VALUES
('Available Slot Time', 'AVL_SLOT_TIME', TO_CHAR(CURRENT_TIMESTAMP, 'YYYY-MM-DD HH24:MI:SS')),
('Slot Time Buffer in min', 'SLOT_TIME_BUFF', '5');


CREATE TABLE bidder (
    bidder_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    slot_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (slot_id) REFERENCES auction_slot(slot_id)
);

CREATE TABLE auction_slot_live (
    live_slot_id SERIAL PRIMARY KEY,
    slot_id INTEGER,
    product_id INTEGER NOT NULL,
    slot_name VARCHAR(100),
    base_price NUMERIC(9,2) NOT NULL,
    current_price NUMERIC(9,2) NOT NULL,
    is_live CHAR(1) NOT NULL,
    auction_exe_id VARCHAR(100) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
