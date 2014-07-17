CREATE TABLE IF NOT EXISTS books (
    user_id     INTEGER NOT NULL,
    title       VARCHAR(255),
    isbn        BIGINT,
    PRIMARY KEY (user_id, isbn)
);

