-- SQL GENERATED BY POWER ARCHITECT

CREATE SEQUENCE university_university_id_seq;

CREATE TABLE University (
                University_ID INTEGER NOT NULL DEFAULT nextval('university_university_id_seq'),
                Name VARCHAR NOT NULL,
                Rector VARCHAR NOT NULL,
                CONSTRAINT university_id PRIMARY KEY (University_ID)
);


ALTER SEQUENCE university_university_id_seq OWNED BY University.University_ID;

CREATE SEQUENCE department_department_id_seq;

CREATE TABLE Department (
                Department_ID INTEGER NOT NULL DEFAULT nextval('department_department_id_seq'),
                University_ID INTEGER NOT NULL,
                Name VARCHAR NOT NULL,
                Address VARCHAR NOT NULL,
                Dean VARCHAR NOT NULL,
                CONSTRAINT department_id PRIMARY KEY (Department_ID)
);


ALTER SEQUENCE department_department_id_seq OWNED BY Department.Department_ID;

CREATE SEQUENCE room_room_id_seq;

CREATE TABLE Room (
                Room_ID INTEGER NOT NULL DEFAULT nextval('room_room_id_seq'),
                Department_ID INTEGER NOT NULL,
                Number VARCHAR NOT NULL,
                Building VARCHAR NOT NULL,
                CONSTRAINT room_id PRIMARY KEY (Room_ID)
);


ALTER SEQUENCE room_room_id_seq OWNED BY Room.Room_ID;

CREATE SEQUENCE subject_subject_id_seq;

CREATE TABLE Subject (
                Subject_ID INTEGER NOT NULL DEFAULT nextval('subject_subject_id_seq'),
                Room_ID INTEGER NOT NULL,
                Name VARCHAR NOT NULL,
                CONSTRAINT subject_id PRIMARY KEY (Subject_ID)
);


ALTER SEQUENCE subject_subject_id_seq OWNED BY Subject.Subject_ID;

CREATE SEQUENCE student_student_id_seq;

CREATE TABLE Student (
                Student_ID INTEGER NOT NULL DEFAULT nextval('student_student_id_seq'),
                Name VARCHAR NOT NULL,
                Surname VARCHAR NOT NULL,
                CONSTRAINT student_id PRIMARY KEY (Student_ID)
);


ALTER SEQUENCE student_student_id_seq OWNED BY Student.Student_ID;

CREATE SEQUENCE student_subject_id_seq;

CREATE TABLE Student_subject (
                ID INTEGER NOT NULL DEFAULT nextval('student_subject_id_seq'),
                Subject_ID INTEGER NOT NULL,
                Student_ID INTEGER NOT NULL,
                CONSTRAINT id PRIMARY KEY (ID)
);


ALTER SEQUENCE student_subject_id_seq OWNED BY Student_subject.ID;

ALTER TABLE Department ADD CONSTRAINT university_department_fk
FOREIGN KEY (University_ID)
REFERENCES University (University_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Room ADD CONSTRAINT department_room_fk
FOREIGN KEY (Department_ID)
REFERENCES Department (Department_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Subject ADD CONSTRAINT room_subject_fk
FOREIGN KEY (Room_ID)
REFERENCES Room (Room_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Student_subject ADD CONSTRAINT subject_student_subject_fk
FOREIGN KEY (Subject_ID)
REFERENCES Subject (Subject_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Student_subject ADD CONSTRAINT student_student_subject_fk
FOREIGN KEY (Student_ID)
REFERENCES Student (Student_ID)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- QUERIES added in SQL Manager for PostgreSQL

select * from student

insert into student (name, surname) VALUES ('Tomasz', 'Gajda');
insert into student (name, surname) VALUES ('Max', 'Verstappen');
insert into student (name, surname) VALUES ('Lewis', 'Hamilton');
insert into student (name, surname) VALUES ('Sebastian', 'Vettel');

insert into university (name, rector) VALUES ('Akademia Górniczo-Hutnicza', 'prof. dr hab. inż. Jerzy Lis');
insert into university (name, rector) VALUES ('Uniwersytet Jagielloński', 'prof. dr hab. Jacek Popiel');
insert into university (name, rector) VALUES ('Uniwersytet Warszawski', 'prof. dr hab. Alojzy Nowak');

insert into department (university_id, name, address, dean) VALUES (1, 'Wydział Fizyki i Informatyki Stosowanej', 'ul. Reymonta 19, 30-059 Kraków', 'prof. dr hab. inż. Bartłomiej Szafran');
insert into department (university_id, name, address, dean) VALUES (2, 'Wydział Fizyki, Astronomii i Informatyki Stosowanej', 'ul. prof. Stanisława Łojasiewicza 11, 30-348 Kraków', 'prof. dr hab. Ewa Gudowska-Nowak');
insert into department (university_id, name, address, dean) VALUES (3, 'Wydział Matematyki, Informatyki i Mechaniki', 'ul. Banacha 2, 02-097 Warszawa', 'prof. dr hab. Paweł Strzelecki');

insert into room (department_id, number, building) VALUES (1, '205A', 'D-10');
insert into room (department_id, number, building) VALUES (1, '204C', 'D-10');
insert into room (department_id, number, building) VALUES (1, '122', 'D-10');
insert into room (department_id, number, building) VALUES (2, '13', 'E12');
insert into room (department_id, number, building) VALUES (2, '111', 'E33');
insert into room (department_id, number, building) VALUES (3, '655', 'W11');

insert into subject (room_id, name) VALUES (1, 'Bazy Danych 1');
insert into subject (room_id, name) VALUES (3, 'Bazy Danych 2');
insert into subject (room_id, name) VALUES (2, 'Metody Numeryczne');
insert into subject (room_id, name) VALUES (6, 'Programowanie Proceduralne');
insert into subject (room_id, name) VALUES (5, 'Algorytmy');
insert into subject (room_id, name) VALUES (5, 'Fizyka 1');

insert into student_subject (subject_id, student_id) VALUES (1, 1);
insert into student_subject (subject_id, student_id) VALUES (3, 1);
insert into student_subject (subject_id, student_id) VALUES (6, 3);
insert into student_subject (subject_id, student_id) VALUES (6, 4);
insert into student_subject (subject_id, student_id) VALUES (5, 4);
insert into student_subject (subject_id, student_id) VALUES (4, 2);

-- testing:
select * from subject
select * from student_subject
select * from room
select * from room