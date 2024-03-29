-- DB University - Queries

-- ESERCIZI CON SELECT

--  1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) = 1990;

--  2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE `cfu` > 10;

--  3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE YEAR(`date_of_birth`) < 1994;

--  4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = 1;

--  5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams` WHERE DATE(`date`) = '2020-06-20' AND HOUR(`hour`) >= 14;

--  6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees` WHERE `level` = 'magistrale';

--  7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(id) as total_department FROM `departments`;

--  8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT * FROM `teachers` WHERE `phone` is NULL;


-- ESERCIZI CON GROUP

--  1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(id)as subscribers FROM `students` GROUP BY YEAR(`enrolment_date`);

--  2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(id) as buldig_number, `office_address` as strett FROM `teachers` GROUP BY strett;

--  3. Calcolare la media dei voti di ogni appello d'esame
SELECT ROUND(AVG(vote)) as avarage_grades, exam_id as id_exam FROM `exam_student` GROUP BY id_exam;

--  4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(id) as degree_courses FROM `degrees` GROUP BY department_id;


-- ESERCIZIO CON JOIN

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT degrees.name AS 'course_name', students.name, students.surname FROM `degrees` JOIN `students` ON degrees.id = students.degree_id WHERE degrees.name = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT degrees.name AS 'course_name', departments.name AS 'departemnt_name' FROM `courses` JOIN `degrees` ON degrees.id = courses.degree_id JOIN `departments` ON departments.id = degrees.department_id WHERE departments.name = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT courses.name AS 'course_name', teachers.id AS 'id', teachers.name, teachers.surname FROM `courses` JOIN `course_teacher` ON courses.id = course_teacher.course_id JOIN `teachers` ON teachers.id = course_teacher.teacher_id WHERE teachers.name = 'Fulvio' AND teachers.surname = 'Amato';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT students.registration_number AS 'freshman', students.name, students.surname, degrees.name AS 'degree_course', departments.name AS 'department_name' FROM `students` JOIN `degrees` ON degrees.id = students.degree_id JOIN `departments` ON departments.id = degrees.department_id ORDER BY students.name, students.surname;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT degrees.name AS 'degree_course_name', courses.name AS 'course_name', teachers.name FROM `degrees` JOIN `courses` ON degrees.id = courses.degree_id JOIN `course_teacher` ON courses.id = course_teacher.course_id JOIN `teachers` ON teachers.id = course_teacher.teacher_id;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)
-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esam