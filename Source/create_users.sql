CREATE TABLE users (
    id       INTEGER       PRIMARY KEY AUTOINCREMENT
                           NOT NULL,
    username VARCHAR (20)  UNIQUE
                           NOT NULL,
    password VARCHAR (255) NOT NULL
);
