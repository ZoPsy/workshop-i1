CREATE TABLE establishment (
    establishment_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);
CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    question_text TEXT,
    explanation TEXT,
    enigme TEXT,
    establishment_id INT,
    FOREIGN KEY (establishment_id) REFERENCES establishment (establishment_id)
);
CREATE TABLE player (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    score INT,
    establishment_id INT NOT NULL,
    FOREIGN KEY (establishment_id) REFERENCES establishment (establishment_id)
);
CREATE TABLE answer (
    answer_id SERIAL PRIMARY KEY,
    answer_text TEXT,
    is_correct BOOLEAN,
    question_id INT,
    FOREIGN KEY (question_id) REFERENCES questions (question_id)
);
INSERT INTO establishment (name) VALUES ('epsi');
INSERT INTO questions (question_text, explanation, establishment_id)
VALUES (
        'Ce comportement correspond à :',
        'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.',
        1
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agissement sexiste',
        true,
        (
            select question_id
            from questions
            where explanation = 'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agression sexuelle',
        false,
        (
            select question_id
            from questions
            where explanation = 'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Harcèlement sexuelle',
        false,
        (
            select question_id
            from questions
            where explanation = 'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Séduction ou drague',
        false,
        (
            select question_id
            from questions
            where explanation = 'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.'
        )
    );
INSERT INTO questions (question_text, explanation, establishment_id)
VALUES (
        'Ce comportement correspond à :',
        'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."',
        1
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agissement sexiste',
        true,
        (
            select question_id
            from questions
            where explanation = 'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agression sexuelle',
        false,
        (
            select question_id
            from questions
            where explanation = 'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Harcèlement sexuelle',
        false,
        (
            select question_id
            from questions
            where explanation = 'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Séduction ou drague',
        false,
        (
            select question_id
            from questions
            where explanation = 'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."'
        )
    );