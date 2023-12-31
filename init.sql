CREATE TABLE establishment (
    establishment_id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);
CREATE TABLE questions (
    question_id SERIAL PRIMARY KEY,
    question_text TEXT,
    number INT,
    explanation TEXT,
    enigme TEXT
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
CREATE TABLE establishment_question (
    establishment_id INT,
    question_id INT,
    FOREIGN KEY (establishment_id) REFERENCES establishment (establishment_id),
    FOREIGN KEY (question_id) REFERENCES questions (question_id)
);
INSERT INTO establishment (name)
VALUES ('epsi');
INSERT INTO questions (
        question_text,
        explanation,
        enigme,
        number
    )
VALUES (
        'Ce comportement correspond à :',
        'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.',
        'Je suis un espace clos, un lieu discret en hauteur, Où certains ont souffert, dans l''''obscurité, avec douleur. Je relie les étages, mais je ne suis pas un escalier, Je suis l''''endroit où se cachent des secrets, et où il faut s''''efforcer de lutter. Pour comprendre ce fléau, nous devons prendre de la hauteur, Visiter cet endroit pour éclairer les cœurs. La sensibilisation est la clé, pour un avenir plus lumineux, Dans cet espace confiné, où le harcèlement peut être odieux.',
        1
    );
INSERT INTO questions (
        question_text,
        explanation,
        enigme,
        number
    )
VALUES (
        'Ce comportement correspond à :',
        'Vous êtes en réunion d''équipe avec vos collègues. Lorsque vous commencez à présenter votre projet, l''un de vos collègues, Mark, fait des commentaires sur votre apparence physique et, exceptionnellement dit : "Tu es vraiment sexy dans cette tenue, ça fait plaisir à voir."',
        'Je suis l''endroit où l''on se retire pour un moment de réflexion, Un lieu d''intimité où chacun devrait trouver sa protection. Cependant, parfois, des ombres s''insinuent en ces lieux, Là où le respect devrait régner, des actes déplacés peuvent avoir lieu. Le harcèlement se cache dans l''obscurité des mots et des gestes, Dans ces endroits, un lieu de harcèlement où la douleur s''atteste. Sensibiliser est notre quête, révéler ces abris, Pour qu''aucune obscurité n''y cache actes impolis.',
        2
    );
INSERT INTO questions (
    question_text,
    explanation,
    enigme,
    number
)
VALUES (
           'Cette situation est-elle un mythe ou une réalité ?',
           'Si quelqu''un est réellement victime de harcèlement sexuel au travail, il le signalera immédiatement',
           'Dans un coin de l''entreprise, discrète et petite, Je sers l''énergie, je réveille les âmes endormies. L''eau chaude coule, le parfum du café embaume, Mais dans les couloirs, parfois, règne un autre royaume. Des regards de trop près, des mots de travers, Dans ces moments d''insouciance naissent parfois des revers. Mon lieu est sûr, mais dans l''ombre parfois se glisse, Ce qu''on ne devrait pas tolérer, ce qui fait mal, ce qui blesse. Où suis-je donc, cet endroit souvent animé, Où règne la convivialité, mais où peut se cacher la réalité ?',
           3
       );
INSERT INTO questions (
    question_text,
    explanation,
    enigme,
    number
)
VALUES (
           'Ce comportement correspond à :',
           'Il y a deux semaines, Sarah a été confrontée à des commentaires inappropriés de la part de son manager. Lundi dernier, ces remarques sur son apparence ont persisté, et aujourd''hui encore, il a fait des commentaires déplacés.',
           '',
           4
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agissement sexiste',
        false,
        (
            select question_id
            from questions
            where explanation = 'Lors de la dernière soirée d''entreprise, après quelques verres, une collègue, Lisa, commence à toucher de manière inappropriée un autre collègue, John, malgré son refus clair et ses tentatives pour s''éloigner.'
        )
    );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
        'Agression sexuelle',
        true,
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
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Mythe',
           true,
           (
               select question_id
               from questions
               where explanation = 'Si quelqu''un est réellement victime de harcèlement sexuel au travail, il le signalera immédiatement'
           )
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Réalité',
           false,
           (
               select question_id
               from questions
               where explanation = 'Si quelqu''un est réellement victime de harcèlement sexuel au travail, il le signalera immédiatement'
           )
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Séduction ou drague',
           false,
           (
               select question_id
               from questions
               where explanation = 'Il y a deux semaines, Sarah a été confrontée à des commentaires inappropriés de la part de son manager. Lundi dernier, ces remarques sur son apparence ont persisté, et aujourd''hui encore, il a fait des commentaires déplacés.'
           )
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Agression sexuelle',
           false,
           (
               select question_id
               from questions
               where explanation = 'Il y a deux semaines, Sarah a été confrontée à des commentaires inappropriés de la part de son manager. Lundi dernier, ces remarques sur son apparence ont persisté, et aujourd''hui encore, il a fait des commentaires déplacés.'
           )
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Harcèlement sexuel',
           true,
           (
               select question_id
               from questions
               where explanation = 'Il y a deux semaines, Sarah a été confrontée à des commentaires inappropriés de la part de son manager. Lundi dernier, ces remarques sur son apparence ont persisté, et aujourd''hui encore, il a fait des commentaires déplacés.'
           )
       );
INSERT INTO answer (answer_text, is_correct, question_id)
VALUES (
           'Agissement sexiste',
           false,
           (
               select question_id
               from questions
               where explanation = 'Il y a deux semaines, Sarah a été confrontée à des commentaires inappropriés de la part de son manager. Lundi dernier, ces remarques sur son apparence ont persisté, et aujourd''hui encore, il a fait des commentaires déplacés.'
           )
       );
INSERT INTO establishment_question (establishment_id, question_id)
VALUES (1, 1),
    (1, 2),
    (1, 3),
    (1, 4);
