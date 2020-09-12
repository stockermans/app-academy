DROP TABLE plays;
DROP TABLE playwrights;

CREATE TABLE plays (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  year INTEGER NOT NULL,
  playwright_id INTEGER NOT NULL,

  FOREIGN KEY (playwright_id) REFERENCES playwrights(id)
);

CREATE TABLE playwrights (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  birth_year INTEGER
);

INSERT INTO
  playwrights(name, birth_year)
VALUES
  ('Arthur Miller', 1915),
  ('Eugene O''Niel', 1888);

INSERT INTO
  plays (title, year, playwright_id)
VALUES
  ('All My Sons', 1947,
    (
      SELECT id FROM playwrights WHERE name = 'Arthur Miller'
    )
  ),
  ('Long Day''s Journey Into Night', 1956,
    (
      SELECT id FROM playwrights WHERE name = 'Eugene O''Niel'
    )
  );

/*

cat import_db.sql | sqlite3 plays.db

.tables # shows tables
.schema # shows schema

# In pry

require 'sqlite3'
plays_db = SQLite3::Database.new('./plays.db')
plays_db.execute("SELECT * FROM plays")
plays_db.execute("INSERT INTO plays (title, year, playwright_id) VALUES ('The Glass Menagerie', 1944, 3)")

*/