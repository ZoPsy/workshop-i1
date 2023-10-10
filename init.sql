CREATE TABLE establishment (
    establishment_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    question_text TEXT,
    explanation TEXT,
    establishment_id INT,
    FOREIGN KEY (establishment_id) REFERENCES establishment (establishment_id)
);

CREATE TABLE player (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    score VARCHAR(50),
    establishment_id INT NOT NULL,
    FOREIGN KEY (establishment_id) REFERENCES establishment (establishment_id)
);

CREATE TABLE answer (
    answer_id SERIAL PRIMARY KEY,
    answer_text VARCHAR(255),
    is_correct BOOLEAN,
    question_id INT,
    FOREIGN KEY (question_id) REFERENCES questions (question_id)
);
