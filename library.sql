-- library_db 데이터베이스 생성
DROP DATABASE library_db;
CREATE DATABASE library_db;
USE library_db;

DROP USER 'library_user'@'localhost';
DROP USER 'library_manager'@'localhost';
-- 계정 생성
CREATE USER 'library_user'@'localhost' IDENTIFIED BY '1234';		-- user 계정
CREATE USER 'library_manager'@'localhost' IDENTIFIED BY '0000';		-- manager 계정

-- library_user 권한 부여 (select,insert,update,delete)
GRANT SELECT, INSERT, UPDATE
ON library_db.* TO 'library_user'@'localhost';

-- library_manager 권한 부여
GRANT ALL PRIVILEGES
ON library_db.* TO 'library_manager'@'localhost';



-- Customers 테이블
CREATE TABLE Customers (
  id INT NOT NULL auto_increment,
  `name` VARCHAR(100) NOT NULL,
  email VARCHAR(100) NULL,
  phone_number VARCHAR(20) NOT NULL,
  birth_date DATE NULL,
  name_id VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE INDEX email_UNIQUE (email ASC) ,
  UNIQUE INDEX phone_number_UNIQUE (phone_number ASC)) ;


-- Types 테이블
CREATE TABLE Types (
  type_id INT NOT NULL AUTO_INCREMENT,
  type_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (type_id),
  UNIQUE INDEX type_name_UNIQUE (type_name ASC) );


-- Publishers 테이블
CREATE TABLE Publishers (
  publisher_id INT NOT NULL AUTO_INCREMENT,
  publisher_name VARCHAR(45) NOT NULL,
  publisher_number varchar(20) not null,
  publisher_email varchar(100) not null,
  PRIMARY KEY (publisher_id),
  UNIQUE INDEX publisher_email_UNIQUE (publisher_email ASC) ,
  UNIQUE INDEX publisher_number_UNIQUE (publisher_number ASC));


-- Authors 테이블
CREATE TABLE Authors (
  author_id INT NOT NULL AUTO_INCREMENT,
  author_name VARCHAR(45) NOT NULL,
  author_email varchar(100) not null,
  PRIMARY KEY (author_id),
  UNIQUE INDEX author_email_UNIQUE (author_email ASC));



-- Books 테이블
CREATE TABLE Books (
  id INT NOT NULL auto_increment,
  title VARCHAR(200) NOT NULL,
  pub_date DATE NULL,
  rate INT NULL,
  stock INT NULL,
  Locations_id INT NOT NULL unique,
  type_id INT NOT NULL,
  publisher_id INT NOT NULL,
  author_id INT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_Books_Types1_idx (type_id ASC) ,
  INDEX fk_Books_Publishers1_idx (publisher_id ASC) ,
  INDEX fk_Books_Authors1_idx (author_id ASC) ,
  CONSTRAINT fk_Books_Types1
    FOREIGN KEY (type_id)
    REFERENCES library_db.Types (type_id)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Books_Publishers1
    FOREIGN KEY (publisher_id)
    REFERENCES library_db.Publishers (publisher_id)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Books_Authors1
    FOREIGN KEY (author_id)
    REFERENCES library_db.Authors (author_id)
    ON DELETE cascade
    ON UPDATE NO ACTION);

drop table Rental;
-- Rental 테이블
CREATE TABLE Rental (
  rental_id INT NOT NULL auto_increment,
  book_id INT NOT NULL,
  customer_id INT NOT NULL,
  rental_date DATE NOT NULL,
  return_expect date not null,
  real_return DATE NULL,
  PRIMARY KEY (rental_id),
  INDEX fk_Rental_Customers_idx (customer_id ASC) ,
  INDEX fk_Rental_Books1_idx (book_id ASC) ,
  CONSTRAINT fk_Rental_Customers
    FOREIGN KEY (customer_id)
    REFERENCES library_db.Customers (id)
    ON DELETE cascade
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Rental_Books1
    FOREIGN KEY (book_id)
    REFERENCES library_db.Books (id)
    ON DELETE cascade
    ON UPDATE NO ACTION);

drop table Customers;
-- Customers
INSERT INTO Customers (id, name, email, phone_number, birth_date, name_id, password) 
VALUES
(1, '남승균', 'skyun.nam@gmail.com', '010-4545-7672', '1980-07-13', 'master', 'master123'),
(2, '이건민', 'chulsoo.kim@example.com', '010-1234-5678', '1985-02-14', 'chulsoo85', 'password123'),
(3, '서민정', 'younghee.lee@example.com', '010-9876-5432', '1990-07-25', 'younghee90', 'mypassword456'),
(4, '한준희', 'minjun.park@example.com', '010-3456-7890', '1995-10-12', 'minjun95', 'secure789'),
(5, '문호정', 'sumin.choi@example.com', '010-5678-9012', '1988-03-04', 'sumin88', 'hello321'),
(6, '유예진', 'haneul.jeong@example.com', '010-4321-8765', '1992-05-18', 'haneul92', 'pw987654'),
(7, '김경민', 'dayoung.kim@example.com', '010-8765-4321', '1993-11-23', 'dayoung93', 'pass4321'),
(8, '나현석', 'junho.lee@example.com', '010-7890-1234', '1987-01-30', 'junho87', 'qwerty987'),
(9, '육준일', 'seojin.yoon@example.com', '010-2345-6789', '1999-09-05', 'seojin99', 'sunshine99'),
(10, '곽승환', 'woojin.jang@example.com', '010-6789-0123', '1984-06-11', 'woojin84', 'moonlight84'),
(11, '김연경', 'yerin.hwang@example.com', '010-9012-3456', '1996-12-20', 'yerin96', 'starlight96'),
(12, '한정식', 'hanjung.sik@example.com', '010-9888-7477', '2001-01-20', 'name', 'pass');


-- Types
INSERT INTO Types (type_name)
VALUES
('과학'),
('기술'),
('비소설'),
('소설'),
('역사'),
('철학'),
('예술'),
('심리학'),
('정치학'),
('경제학');


-- Publishers
INSERT INTO Publishers (publisher_name, publisher_number, publisher_email)
VALUES
('문학동네', '02-445-7765', 'literature@examlple.com'),
('민음사', '02-856-5513', 'believe@examlple.com'),
('시공사', '02-862-7754', 'construction@examlple.com'),
('창비', '031-469-5571', 'window@examlple.com'),
('한빛미디어', '02-571-6289', 'onelight@examlple.com'),
('열린책들', '052-335-1918', 'openbooks@examlple.com'),
('한길사', '032-635-1175', 'oneway@examlple.com'),
('고즈넉한 집', '02-372-2712', 'house@examlple.com'),
('씨앗을 뿌리다', '031-317-3315', 'sowseed@examlple.com'),
('미래사', '02-745-8110', 'future@examlple.com');


-- Authors
INSERT INTO Authors (author_name, author_email)
VALUES
('김영하', 'underzero@example.com'),
('조정래', 'rowing@example.com'),
('정유정', 'ubetweenjeong@example.com'),
('유발 하라리', 'uleg@example.com'),
('박완서', 'wanwest@example.com'),
('조지 오웰', 'fivewell@example.com'),
('레프 톨스토이', 'tolstoy@example.com'),
('다자이 오사무', 'fivefournothing@example.com'),
('J.R.R. 톨킨', 'jrr@example.com'),
('F. 스콧 피츠제럴드', 'scott@example.com'),
('아고타 크리스토프', 'krostof@example.com'),
('한강', 'hanriver@example.com'),
('제인 오스틴', 'jo@example.com');



-- Books
INSERT INTO Books (id, title, pub_date, rate, stock, Locations_id, type_id, publisher_id, author_id)
VALUES
(1, '살인자의 기억법', '2013-07-25', 5, 1, 100101, 4, 1, 1),
(2, '태백산맥', '1987-10-01', 4, 1, 100102, 4, 4, 2),
(3, '7년의 밤', '2011-05-15', 4, 1, 100303, 4, 2, 3),
(4, '사피엔스', '2015-02-02', 5, 1, 200304, 3, 5, 4),
(5, '무소의 뿔처럼 혼자서 가라','1994-02-02', 4, 1, 200301, 4, 1, 5),
(6, '1984','1949-06-08', 5, 1, 300706, 4, 2, 6),
(7, '안나 카레니나','1877-01-01', 5, 1, 105007, 3, 2, 7),
(8, '인간 실격','1948-06-05', 5, 1, 100608, 3, 8, 8),
(9, '반지의 제왕','1954-07-29', 5, 0, 101109, 4, 7, 9),
(10, '위대한 개츠비','1925-04-10', 4, 0, 110510, 4, 6, 10),
(11, '존재의 세가지 거짓말','1925-05-12', 5, 1, 101510, 4, 6, 11),
(12, '채식주의자','2022-03-28', 5, 1, 201715, 1, 4, 12),
(13, '문맹', '2020-10-12', 5, 1, 105706, 1, 6, 11),
(14, '소년이 온다','2014-05-19', 5, 1, 141017, 1, 4, 12),
(15, '오만과 편견','1998-12-14', 4, 1, 141049, 1, 5, 13);

drop table rental;
-- Rental
INSERT INTO Rental (rental_id, book_id, customer_id, rental_date, return_expect, real_return)
VALUES
(1, 1, 1, '2024-11-01', '2024-11-10', '2024-11-05'),
(2, 2, 2, '2024-11-03', '2024-11-12', '2024-11-10'),
(3, 3, 3, '2024-11-05', '2024-11-14' , '2024-11-12'),
(4, 4, 4, '2024-11-07', '2024-11-16','2024-11-14'),
(5, 5, 5, '2024-11-09', '2024-11-18', '2024-11-15'),
(6, 6, 6, '2024-11-10', '2024-11-19','2024-11-21'),  -- 연체
(7, 7, 7, '2024-11-12', '2024-11-21', '2024-11-15'),
(8, 8, 8, '2024-11-14', '2024-11-23','2024-11-17'),
(9, 9, 9, '2024-11-15', '2024-11-24',  null ),
(10, 10, 10, '2024-11-16', '2024-11-25' , null );

SELECT * FROM Customers;
SELECT * FROM Types;
SELECT * FROM Publishers;
SELECT * FROM Authors;
SELECT * FROM Books;
SELECT * FROM Rental;
SELECT Books.id, Books.title, Types.type_name, Publishers.publisher_name, Books.pub_date, Books.rate, Books.stock, Books.Locations_id, Books.type_id, Books.publisher_id, Books.author_id
FROM Books, Publishers, Types WHERE Books.type_id = Types.type_id AND Books.publisher_id = Publishers.publisher_id;

insert into Publishers (publisher_name, publisher_email, publisher_number) values (?, ?, ?);
insert into Authors (author_name, author_email) values (?, ?, ?);
SELECT return_expect
FROM rental
WHERE book_id = ? AND real_return IS NULL;