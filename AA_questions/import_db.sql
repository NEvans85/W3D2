CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(50) NOT NULL,
  lname VARCHAR(50) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id INTEGER NOT NULL,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  author_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  body VARCHAR(255) NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (author_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply_id) REFERENCES id
);


CREATE TABLE question_likes(
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Brian', 'Scott'),
  ('Robert', 'Scott'),
  ('Chuck', 'Miller');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('directions', 'where is AA located?',
    (SELECT id FROM users WHERE fname = 'Chuck' AND lname = 'Miller')),
  ('furthermore', 'one more question...',
    (SELECT id FROM users WHERE fname = 'Brian' AND lname = 'Scott')),
  ('lunchtime', 'when is lunchtime?',
    (SELECT id FROM users WHERE fname = 'Robert' AND lname = 'Scott')),
  ('lost and found', 'did I leave that thing at AA?',
    (SELECT id FROM users WHERE fname = 'Chuck' AND lname = 'Miller'));


INSERT INTO
  replies (question_id, author_id, parent_reply_id, body)
VALUES
  (3, 1, NULL, '12:00'),
  (3, 3, 1, 'yes it just switched from 12:15'),
  (4, 2, NULL, 'yup, mine now!');

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1, 3),
  (1, 2),
  (4, 1);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (2, 3),
  (3, 1),
  (4, 2);
