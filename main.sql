-- Define sessions table  
CREATE TABLE sessions (  
    id VARCHAR(64) PRIMARY KEY,  
    value TEXT NOT NULL  
);  
  
-- Define users table  
CREATE TABLE users (  
    id BIGSERIAL PRIMARY KEY,  
    username VARCHAR(64) UNIQUE,  
    display_name VARCHAR(48) NOT NULL,
    hashed_password VARCHAR(128) NOT NULL,  
    salt VARCHAR(64) NOT NULL  
);  
  
-- Define collections table  
CREATE TABLE collections (  
    id BIGSERIAL PRIMARY KEY,  
    title TEXT NOT NULL,  
    description TEXT,  
    known_language_iso_639_1 VARCHAR(2),  
    learning_language_iso_639_1 VARCHAR(2),  
    owner_id BIGSERIAL NOT NULL,  
    CONSTRAINT owner_id_fk FOREIGN KEY (owner_id) REFERENCES users(id)  
);  
  
-- Define cards table  
CREATE TABLE cards (
    id BIGSERIAL PRIMARY KEY,  
    known_language_text TEXT NOT NULL,
    learning_language_text TEXT NOT NULL,
    notes TEXT NOT NULL,
    last_answered_at TIMESTAMP, 
    show_next_time_at TIMESTAMP, 
    correct_answers_in_row INT DEFAULT 0 NOT NULL,  
    owner_id BIGINT NOT NULL,  
    CONSTRAINT owner_id_fk FOREIGN KEY (owner_id) REFERENCES users(id)  
);

-- Define examples table
CREATE TABLE examples (
    id BIGSERIAL PRIMARY KEY,
    known_language_text TEXT NOT NULL,
    learning_language_text TEXT NOT NULL,
    card_id BIGSERIAL NOT NULL,
    CONSTRAINT card_id_fk FOREIGN KEY (card_id) REFERENCES cards(id)
);

-- Define a table of collection and card relationships
CREATE TABLE collections_cards (
    id BIGSERIAL PRIMARY KEY,
    collection_id BIGSERIAL NOT NULL,
    card_id BIGSERIAL NOT NULL,
    CONSTRAINT collection_id_fk FOREIGN KEY (collection_id) REFERENCES collections(id),
    CONSTRAINT card_id_fk FOREIGN KEY (card_id) REFERENCES cards(id)
);