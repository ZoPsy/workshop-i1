CREATE TABLE establishment (
    establishment_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);
CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    question_text TEXT,
    number INT,
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
INSERT INTO establishment (name)
VALUES ('epsi');
INSERT INTO questions (
        question_text,
        explanation,
        enigme,
        number,
        establishment_id
    )
VALUES (
        'Ce comportement correspond à :',
        'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.',
        'Je suis un espace clos, un lieu discret en hauteur, Où certains ont souffert, dans l''''obscurité, avec douleur. Je relie les étages, mais je ne suis pas un escalier, Je suis l''''endroit où se cachent des secrets, et où il faut s''''efforcer de lutter. Pour comprendre ce fléau, nous devons prendre de la hauteur, Visiter cet endroit pour éclairer les cœurs. La sensibilisation est la clé, pour un avenir plus lumineux, Dans cet espace confiné, où le harcèlement peut être odieux.',
        1,
        1
    );
INSERT INTO questions (
        question_text,
        explanation,
        enigme,
        number,
        establishment_id
    )
VALUES (
        'Ce comportement correspond à :',
        'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."',
        'Je suis l''endroit où l''on se retire pour un moment de réflexion, Un lieu d''intimité où chacun devrait trouver sa protection. Cependant, parfois, des ombres s''insinuent en ces lieux, Là où le respect devrait régner, des actes déplacés peuvent avoir lieu. Le harcèlement se cache dans l''obscurité des mots et des gestes, Dans ces endroits, un lieu de harcèlement où la douleur s''atteste. Sensibiliser est notre quête, révéler ces abris, Pour qu''aucune obscurité n''y cache actes impolis.',
        2,
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