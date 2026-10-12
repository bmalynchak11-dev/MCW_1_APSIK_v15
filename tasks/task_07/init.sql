-- 1. Створення ролей
CREATE ROLE app_rw WITH LOGIN PASSWORD 'lab-only';
CREATE ROLE app_ro WITH LOGIN PASSWORD 'lab-only';
CREATE ROLE backup WITH LOGIN PASSWORD 'lab-only';

-- 2. Створення бази та обмеження доступу
CREATE DATABASE shop;
REVOKE CONNECT ON DATABASE shop FROM PUBLIC;
GRANT CONNECT ON DATABASE shop TO app_rw, app_ro, backup;

-- 3. Створення таблиці orders у базі shop
\c shop

CREATE TABLE orders (
    id int,
    item text
);

-- 4. Призначення привілеїв
GRANT SELECT, INSERT, UPDATE ON TABLE orders TO app_rw;
GRANT SELECT ON TABLE orders TO app_ro, backup;