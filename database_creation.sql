CREATE DATABASE brazil-dances;
-- Creating the 'users' table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_type ENUM('admin', 'user'),
    username VARCHAR(100),
    password_hash CHAR(64),
    email_hash VARCHAR(255),
    created_at TIMESTAMP
);

CREATE TABLE dance_categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE dances (
    dance_id INT PRIMARY KEY,
    dance_name VARCHAR(100),
    category_id INT,
    description TEXT,
    image_id INT,
    region VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES dance_categories(category_id),
    FOREIGN KEY (image_id) REFERENCES media(media_id)
);

CREATE TABLE media (
    media_id INT PRIMARY KEY,
    media_url VARCHAR(255),
    alttext VARCHAR(255)
);

CREATE TABLE region (
    region_key INT PRIMARY KEY,
    region_name VARCHAR(100),
    dance_id INT,
    FOREIGN KEY (dance_id) REFERENCES dances(dance_id)
);

CREATE TABLE preferences (
    preference_id INT PRIMARY KEY,
    user_id INT,
    dance_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (dance_id) REFERENCES dances(dance_id)
);
