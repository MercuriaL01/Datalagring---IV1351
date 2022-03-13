INSERT INTO historical.lesson (lesson_id, "location", skill_level, instrument, lesson_number_of_places,
 number_of_lesson_places_taken, minimum_number_of_students, target_genre, lesson_time, price_amount, lesson_type)
SELECT 
lesson.lesson_id, lesson.location, skill_level."level" AS skill_level, instrument.type_of_instrument AS instrument,
non_individual_lesson.lesson_number_of_places, non_individual_lesson.number_of_lesson_places_taken,
non_individual_lesson.minimum_number_of_students, ensemble.target_genre, 
CASE 
WHEN scheduled_time_slot.lesson_time IS NOT NULL 
THEN scheduled_time_slot.lesson_time 
ELSE individual_lesson.individual_lesson_time
END AS "lesson_time", 
pricing_scheme.price_amount, 
CASE 
WHEN individual_lesson.individual_lesson_time IS NOT NULL 
THEN 'individual_lesson'
WHEN  ensemble.target_genre IS NOT NULL 
THEN 'ensemble'
ELSE 'non_ensemble_group_lesson'
END AS "lesson_type"
FROM lesson
FULL OUTER JOIN 
individual_lesson
ON lesson.lesson_id = individual_lesson.lesson_id
FULL OUTER JOIN
non_individual_lesson
ON lesson.lesson_id = non_individual_lesson.lesson_id
FULL OUTER JOIN scheduled_time_slot
ON lesson.lesson_id = scheduled_time_slot.lesson_id
FULL OUTER JOIN 
ensemble
ON lesson.lesson_id = ensemble.lesson_id
FULL OUTER JOIN 
instrument
ON lesson.instrument_id = instrument.instrument_id
FULL OUTER JOIN 
skill_level
ON lesson.skill_level_id = skill_level.skill_level_id
FULL OUTER JOIN
pricing_scheme
ON lesson.lesson_id = pricing_scheme.lesson_id
ORDER BY lesson.lesson_id;

INSERT INTO historical.student (student_id, first_name, last_name, age, person_number, email)
SELECT person.person_id AS student_id, person.first_name, person.last_name, person.age, 
person.person_number, person.email FROM person
INNER JOIN 
student
ON person.person_id = student.person_id
ORDER BY person.person_id;

INSERT INTO historical.lesson_student (lesson_id, student_id)
SELECT booking.lesson_id, booking.person_id AS student_id
FROM 
booking
ORDER BY booking.lesson_id;


--För att verifiera att det är korrekt
--SELECT * FROM 
--historical.lesson
--FULL OUTER JOIN
--historical.lesson_student
--ON historical.lesson.lesson_id = historical.lesson_student.lesson_id
--FULL OUTER JOIN 
--historical.student 
--ON historical.student.student_id = historical.lesson_student.student_id
--ORDER BY historical.lesson.lesson_id