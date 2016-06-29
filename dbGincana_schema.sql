--
-- File generated with SQLiteStudio v3.0.7 on ter mai 31 23:08:52 2016
--
-- Text encoding used: windows-1252
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: items
DROP TABLE IF EXISTS items;

CREATE TABLE items (
    id          INTEGER       PRIMARY KEY AUTOINCREMENT
                              NOT NULL,
    box_number  INTEGER       NOT NULL,
    year        INTEGER       NOT NULL,
    keywords    TEXT          NOT NULL,
    description VARCHAR (255),
    created_at  DATETIME      DEFAULT (CURRENT_TIMESTAMP) 
                              NOT NULL,
    updated_at  DATETIME      DEFAULT (CURRENT_TIMESTAMP) 
                              NOT NULL
);


-- Index: idx_items_box
DROP INDEX IF EXISTS idx_items_box;

CREATE INDEX idx_items_box ON items (
    box_number ASC
);


-- Index: idx_items_year
DROP INDEX IF EXISTS idx_items_year;

CREATE INDEX idx_items_year ON items (
    year ASC
);


-- Index: idx_items_description
DROP INDEX IF EXISTS idx_items_description;

CREATE INDEX idx_items_description ON items (
    description
);


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
