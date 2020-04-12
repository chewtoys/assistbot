DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS requests CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    avatar VARCHAR(255) UNIQUE NOT NULL,
    twitch_id VARCHAR(32) UNIQUE NOT NULL
);

CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  description TEXT,
  type VARCHAR(32),
  created_at TIMESTAMP DEFAULT (now() AT TIME ZONE 'utc'),
  updated_at TIMESTAMP DEFAULT (now() AT TIME ZONE 'utc'),
  accepted_at TIMESTAMP,
  completed_at TIMESTAMP,
  users_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now() AT TIME ZONE 'utc';
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_timestamp
BEFORE UPDATE ON requests
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();