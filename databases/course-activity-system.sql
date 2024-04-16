-- Ajo-ohjeita kannan käyttöönottoo:
--
-- 1) Kirjaudu tietokantakoneeseen
--
-- 2 vaihtoehto a) Avaa mysql-ohjelma ja copy-pastea kaikki
-- alla oleva.
--
-- 2 vaihtoehto b) Lataa tiedosto ja aja se kantaa vasten
-- wget URL
-- mysql -uadmin -p < course-activity-system.sql


-- Luodaan tietokanta (poistaa olemassa olevan)

DROP DATABASE IF EXISTS ca_system;

CREATE DATABASE ca_system;

-- Otetaan luotu tietokanta käyttöön
USE ca_system;

-- Luodaan taulut

CREATE TABLE Students (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(400) NOT NULL,
	lastname VARCHAR(400) NOT NULL,
	email VARCHAR(400) NOT NULL UNIQUE,
	password VARCHAR(400) NOT NULL,
	lastActive DATETIME,
	createdAt DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE Courses (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(400) NOT NULL,
	code VARCHAR(400) NOT NULL UNIQUE,
	createdAt DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE Notes (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	courseId INT NOT NULL,
	studentId INT NOT NULL,
	note TEXT NOT NULL,
	createdAt DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (courseId) REFERENCES Courses(id),	
	FOREIGN KEY (studentId) REFERENCES Students(id)
);

CREATE TABLE SpecialDates (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	courseId INT,
	studentId INT NOT NULL,
	title VARCHAR(400) NOT NULL,
	timestamp TIMESTAMP NOT NULL,
	createdAt DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (courseId) REFERENCES Courses(id),	
	FOREIGN KEY (studentId) REFERENCES Students(id)
);

CREATE TABLE Grades (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	grade CHAR(3) NOT NULL UNIQUE
);

CREATE TABLE StudentGrades (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	courseId INT NOT NULL,
	studentId INT NOT NULL,
	gradeId INT NOT NULL,
	createdAt DATETIME NOT NULL DEFAULT NOW(),
	FOREIGN KEY (courseId) REFERENCES Courses(id),	
	FOREIGN KEY (studentId) REFERENCES Students(id),
	FOREIGN KEY (gradeId) REFERENCES Grades(id)
);

-- Populoidaan taulut (laitetaan tauluihin dataa)

-- Arvosanat
INSERT INTO Grades (grade) VALUES ("HYV"), ("E1"), ("E2"), (0), (1), (2), (3), (4), (5);

-- Kursseja

INSERT INTO Courses (name, code)
VALUES ("SQL", "IC2319-001"), ("Java", "IC2320-002"), ("SQL", "IC2319-002");


-- Muutama opiskelija (yksi ei ole kirjaitunut kertaakaan sisään)
INSERT INTO Students (firstname, lastname, email, password, createdAt, lastActive) VALUES ('Giraud', 'McCrainor', 'gmccrainor2@purevolume.com', '$2a$04$1VQAj9txSbmdFuV6BH4/BOlR5q6Ave7P8byccZzF6NbJKFI1ipXPK', '2023-10-19 16:57:16', '2023-06-19 08:01:14');
INSERT INTO Students (firstname, lastname, email, password, createdAt, lastActive) VALUES ('Jaye', 'Lockitt', 'jlockitt3@blogtalkradio.com', '$2a$04$2zJRIy0s..HK0YKnO0vVkOP7WfeznWlSkpGGFv0S1vzyPkRxoX8PK', '2023-11-05 06:38:49', '2024-02-14 12:39:26');
INSERT INTO Students (firstname, lastname, email, password, createdAt, lastActive) VALUES ('Alfie', 'Shorthouse', 'ashorthouse4@jalbum.net', '$2a$04$ooV3sVB3Knp0ufAgpvXW0.dbcHlhAppnQFdgcz0aDH6p8fKFH9lmG', '2023-04-20 20:40:06', null);

-- Muistiinpanoja

-- courseId INT NOT NULL,
-- studentId INT NOT NULL,
-- note TEXT NOT NULL,

INSERT INTO Notes (courseId, studentId, note)
VALUES (1, 2, "Where-clause filters from the table"),
(1,2, "Having-clause filters the result set"),
(2,1, "Integer divided by integer produces integer"),
(2,1, "Strings are objects"),
(2,2, "Java and JavaScript are not the same");

-- Päivämääriä
INSERT INTO SpecialDates (courseId, studentId, title, timestamp)
VALUES (1,1, "SQL final exam", "2024-05-01 10:00:00"),
(NULL, 2, "Tutor meeting, room A247", "2024-04-22 18:00:00");

-- Arvosanoja opiskelijoille
-- Opiskelija on saanut jostakin aiemmasta toteutuksesta hylätyn
INSERT INTO StudentGrades (courseId, studentId, gradeId)
VALUES (1,1,4);
