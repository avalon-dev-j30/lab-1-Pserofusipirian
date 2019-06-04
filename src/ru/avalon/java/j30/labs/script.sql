/*
 * TODO(Студент): Опишите процесс создания базы данных
 * 1. Создайте все таблицы, согласно предложенной диаграмме.
 * 2. Опишите все необходимые отношения между таблицами.
 * 3. Добавьте в каждую таблицу минимум три записи.
 */
DROP TABLE Order2Product;
DROP TABLE Orders;
DROP TABLE Users;
DROP TABLE UserInfo;
DROP TABLE Roles;
DROP TABLE Product;
DROP TABLE Supplier;

CREATE TABLE UserInfo(
    id integer PRIMARY KEY,
    name varchar(255) NOT NULL,
    surname varchar(255) NOT NULL  
);

CREATE TABLE Roles(    
    -- дополнительно запрещаем NULL  
    id integer NOT NULL UNIQUE,
    name varchar(255) PRIMARY KEY  
);

-- имя User пришлось сменить на Users
CREATE TABLE Users(
    -- дополнительно запрещаем NULL
    id integer NOT NULL UNIQUE,
    email varchar(255) PRIMARY KEY,
    password varchar(255),
    -- дополнительно запрещаем NULL
    info integer NOT NULL UNIQUE REFERENCES UserInfo(id),
    role integer REFERENCES Roles(id)  
);

-- имя Order пришлось сменить на Orders
CREATE TABLE Orders(
    id integer PRIMARY KEY,
    -- имя user пришлось сменить на userid
    userid integer REFERENCES Users(id),
    created timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Supplier(
    -- дополнительно запрещаем NULL
    id integer NOT NULL UNIQUE,
    name varchar(255) NOT NULL PRIMARY KEY,
    adress varchar(255) NOT NULL,
    phone varchar(255),
    representative varchar(255) NOT NULL
);

CREATE TABLE Product(
    -- дополнительно запрещаем NULL
    id integer NOT NULL UNIQUE,
    code varchar(255) PRIMARY KEY,
    title varchar(255),
    supplier integer REFERENCES Supplier(id),
    initial_price double,
    retail_value double
);

CREATE TABLE Order2Product(
    orderid integer REFERENCES Orders(id),
    product integer REFERENCES Product(id),
    PRIMARY KEY (orderid, product) 
);

INSERT INTO Roles(id, name) VALUES
    (1, 'admin'),
    (2, 'seller'),
    (3, 'drone');

INSERT INTO UserInfo(id, name, surname) VALUES 
    (1, 'Джузеппе', 'Поварешкин'),
    (2, 'Тарас', 'Фон Вейсенберг'),
    (3, 'Ешимура', 'Иванов');

INSERT INTO Users(id, email, password, info, role) VALUES 
    (1, 'juzeppe@mail.ru', '123', 1, 1),
    (2, 'taras@mail.ru', '54321', 2, 2),
    (3, 'ivanov@mail.ru', 'nFdu&43D@!s', 3, 3);

INSERT INTO Supplier(id, name, adress, phone, representative) VALUES 
    (1, 'Ниф-Ниф', 'Соломенный домик', '9999999', 'Добрыня'),
    (2, 'Нуф-Нуф', 'Деревянный домик', '8888888', 'Алеша'),
    (3, 'Наф-Наф', 'Каменный домик', '7777777', 'Илья');

INSERT INTO Product(id, code, title, supplier, initial_price, retail_value) VALUES 
    (101, 'M325', 'Солома', 1, 12, 17.4),
    (102, 'M864', 'Древесина', 2, 210.5, 315),
    (103, 'M123', 'Газобетонные блоки', 3, 520.70, 699.99);

INSERT INTO Orders(id, userid) VALUES 
    (1, 2),
    (2, 2),
    (3, 2);

INSERT INTO Order2Product(orderid, product) VALUES 
    (1, 102),
    (1, 103),
    (2, 101),
    (2, 102),
    (3, 101),
    (3, 103);