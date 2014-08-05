CREATE TABLE IF NOT EXISTS books (
    user_id     INTEGER NOT NULL,
    isbn        BIGINT,
    own_num     INT,
    lend_num    INT,
    PRIMARY KEY (user_id, isbn)
);

