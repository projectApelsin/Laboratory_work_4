-- Видалення таблиць з каскадним видаленням обмежень цілісності
DROP TABLE IF EXISTS lesson_plan CASCADE;
DROP TABLE IF EXISTS learning_plan CASCADE;
DROP TABLE IF EXISTS lesson CASCADE;
DROP TABLE IF EXISTS "user" CASCADE;

-- Таблиця user
CREATE TABLE user (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT username_format CHECK (
        username ~ '^[a-zA-Z0-9_]+$'
    ),
    CONSTRAINT email_format CHECK (
        email ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,}$'
    )
);

-- Таблиця lesson
CREATE TABLE lesson (
    lesson_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50) NOT NULL,
    difficulty_level INTEGER CHECK (
        difficulty_level BETWEEN 1 AND 5
    )
);

-- Таблиця learning_plan
CREATE TABLE learning_plan (
    plan_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    plan_name VARCHAR(100) NOT NULL UNIQUE,
    creation_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES "user" (user_id)
    ON DELETE CASCADE
);

-- Таблиця lesson_plan
CREATE TABLE lesson_plan (
    lesson_plan_id SERIAL PRIMARY KEY,
    plan_id INTEGER NOT NULL,
    lesson_id INTEGER NOT NULL,
    order_number INTEGER NOT NULL,
    FOREIGN KEY (plan_id) REFERENCES learning_plan (plan_id)
    ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id)
    ON DELETE CASCADE
);
