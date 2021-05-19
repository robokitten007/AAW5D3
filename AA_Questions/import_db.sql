PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions(
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows;

CREATE TABLE question_follows(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL
);

CREATE TABLE replies(
    id INTEGER PRIMARY KEY,
    parent_id INTEGER,
    user_id INTEGER,
    subject_id INTEGER NOT NULL,
    reply TEXT NOT NULL,

    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (subject_id) REFERENCES questions(id)
);

CREATE TABLE question_likes(
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Arthur', 'Miller'),
  ('Eugene O','Neill'),
  ('Wen', 'Liu');


INSERT INTO
  questions (title, body, author_id)
VALUES
  ('cat?', 'where is my cat?', 1),
  ('dog?', 'where is my dog?', 2),
  ('Fridge is gone', 'WHERE IS MY FRIDGE?', 3);

INSERT INTO 
    question_follows(user_id, question_id)
VALUES
    (1,2),
    (2,1),
    (1, 3),
    (2,3);


INSERT INTO 
    replies(parent_id, user_id, subject_id, reply)
VALUES
    (NULL, 3, 1, 'my cat is in the fridge'),
    (1, 2, 1, 'why?'),
    (2, 3, 1, "MY FRIDGE IS MISSING!!!");

INSERT INTO 
    question_likes(user_id, question_id)
VALUES
    (3, 1),
    (2, 1),
    (1, 1);