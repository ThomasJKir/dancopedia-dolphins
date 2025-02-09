SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS brazil_dances;
USE brazil_dances;

CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_type ENUM('admin', 'user'),
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash CHAR(64),
    email_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dance_categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO dance_categories (category_name) VALUES 
('Traditional'), ('Festival'), ('Partner'), ('Pop');

CREATE TABLE IF NOT EXISTS media (
    media_id INT PRIMARY KEY AUTO_INCREMENT,
    media_url VARCHAR(255) UNIQUE,
    alttext VARCHAR(255)
);

INSERT INTO media (media_url, alttext) VALUES 
('media/samba_img.jpg', 'Samba dance image'),
('media/forro_img.jpg', 'Forro dance image'),
('media/frevo_img.jpg', 'Frevo dance image'),
('media/axe_img.jpg', 'Axé dance image'),
('media/bossa_img.jpg', 'Bossa Nova dance image');

CREATE TABLE IF NOT EXISTS dances (
    dance_id INT PRIMARY KEY AUTO_INCREMENT,
    dance_name VARCHAR(100) NOT NULL UNIQUE,
    category_id INT,
    description TEXT,
    media_id INT,
    region VARCHAR(100),
    FOREIGN KEY (category_id) REFERENCES dance_categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (media_id) REFERENCES media(media_id) ON DELETE CASCADE
);

INSERT INTO dances (dance_name, category_id, description, media_id, region) VALUES
('Samba', 1, 'A lively, rhythmical dance with origins in Afro-Brazilian communities, performed at the Carnival.', 1, 'Rio de Janeiro'),
('Forró', 3, 'A close-partner dance from Northeastern Brazil with accordion-driven rhythms.', 2, 'Northeastern Brazil'),
('Frevo', 2, 'An energetic, acrobatic dance performed with colorful umbrellas during Carnival.', 3, 'Pernambuco'),
('Axé', 4, 'A vibrant dance style from Bahia with upbeat moves, popular at parties and festivals.', 4, 'Bahia'),
('Bossa Nova', 4, 'A smooth, intimate dance style with subtle sway, paired with jazzy Bossa Nova music.', 5, 'Rio de Janeiro');

CREATE TABLE IF NOT EXISTS region (
    region_key INT PRIMARY KEY AUTO_INCREMENT,
    region_name VARCHAR(100),
    dance_id INT,
    FOREIGN KEY (dance_id) REFERENCES dances(dance_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS preferences (
    preference_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    dance_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (dance_id) REFERENCES dances(dance_id) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS=1;
