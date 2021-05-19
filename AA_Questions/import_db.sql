PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users

CREATE TABLE users(
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL,
);

DROP TABLE IF EXISTS questions

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    associated_author_id INTEGER NOT NULL,

    FOREIGN KEY (associated_author_id) REFERENCES users(id)
);


DROP TABLE IF EXISTS question_follows

CREATE TABLE question_follows(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
);


DROP TABLE IF EXISTS replies

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    parent_id INTEGER,
    subject_id INTEGER NOT NULL,
    reply TEXT NOT NULL,

    FOREIGN KEY (parent_id) REFERENCES replies(id)
    FOREIGN KEY (subject_id) REFERENCES questions(id)
);

DROP TABLE IF EXISTS question_likes

CREATE TABLE question_likes(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
);
