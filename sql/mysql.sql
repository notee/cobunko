CREATE TABLE IF NOT EXISTS books (
    user_id     INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title       VARCHAR(255),
    isbn        BIGINT
);
