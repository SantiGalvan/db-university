---------------- QUERY CON SELECT ----------------------

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * FROM `students` WHERE `date_of_birth` LIKE '1990-%';

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * FROM `courses` WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT * FROM `students` WHERE `date_of_birth` < '1995-01-01';

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT * FROM `exams` WHERE `date` = '2020-06-20' AND `hour` > '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT * FROM `degrees` WHERE `level` = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(*) AS `n_departments` FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT COUNT(*) AS `n_teachers_phone` FROM `teachers` WHERE `phone` IS NULL;



---------------- QUERY CON GROUP BY ----------------------

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(*) AS `n_students_on_date`, `enrolment_date` FROM `students` GROUP BY `enrolment_date`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(*) AS `n_teachers`, `office_address` FROM `teachers` GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame
SELECT AVG(`vote`) AS `average_vote`, `exam_id` FROM `exam_student` GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`department_id`) AS `n_courses` FROM `degrees` GROUP BY `department_id`;


---------------- QUERY CON JOIN ----------------------

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT S.`id` , S.`name` AS `student_name`, S.`surname` AS `student_surname` FROM `students` AS S JOIN `degrees` AS D ON D.`id` = S.`degree_id` WHERE D.`name` = 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT * FROM `degrees` AS DEG JOIN `departments` AS DEP ON DEP.`id` = DEG.`department_id` WHERE DEP.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT * FROM `courses` AS C JOIN `course_teacher` AS CT ON C.`id` = CT.`course_id` JOIN `teachers` AS T ON T.`id` = CT.`teacher_id` WHERE T.`surname` = 'Amato' AND T.`name` = 'Fulvio';

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome
SELECT S.`name` AS `nome_studente`, S.`surname` AS `cognome_studente`, DEG.`name` AS `nome_corso`, DEP.`name` AS `nome_dipartimento` FROM `students` AS S JOIN `degrees` AS DEG ON DEG.`id` = S.`degree_id` JOIN `departments` AS DEP ON DEP.`id` = DEG.`department_id` ORDER BY S.`name` ASC;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti
SELECT DEG.`name` AS `nome_corso_laurea`, C.`name` AS `nome_corso`, T.`name` AS `teacher_name`, T.`surname` AS `teacher_surname` FROM `degrees` AS DEG JOIN `courses` AS C ON DEG.`id` = C.`degree_id` JOIN `course_teacher` AS CT ON C.`id` = CT.`course_id` JOIN `teachers` AS T ON T.`id` = CT.`teacher_id`;