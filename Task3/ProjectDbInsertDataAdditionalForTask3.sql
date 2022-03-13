INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Instructor', 'Instrcutorson', 28, '19940523-8888', 'instructor@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Instructor'), cast(1 AS bit), 575.50);

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Johan', 'Eriksson', 5, '20160523-8888', 'johan@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Johan'), cast(0 AS bit), 50.50);

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Johanna', 'Svensson', 11, '20100523-8888', 'johanna@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Johanna'), cast(1 AS bit), 7680.00);

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Linnea', 'Lindqvist', 21, '20000523-8888', 'linnea@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Linnea'), cast(0 AS bit), 300.50);

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Steve', 'Jobs', 100, '19210523-8888', 'steve@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Steve'), cast(1 AS bit), 10000.00);

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Sara', 'Backskog', 22, '19990523-8888', 'sara@kth.se');

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Sara'), cast(1 AS bit), 760.00);

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL B1', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO individual_lesson(lesson_id, individual_lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(200, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL B3', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Instructor'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-11 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(250, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL B4', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Johan'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'pop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-02-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(150, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL C1', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Johanna'));

INSERT INTO individual_lesson(lesson_id, individual_lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-03-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(200, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL C2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Sara'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-03-11 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(250, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL C3', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Linnea'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'pop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-03-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(300, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL D1', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Steve'));

INSERT INTO individual_lesson(lesson_id, individual_lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-04-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(275, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL D2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-06-11 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(225, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL D3', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'pop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-08-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(325, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL E1', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Sara'));

INSERT INTO individual_lesson(lesson_id, individual_lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-09-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(175, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL E2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Johanna'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-11-11 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(220, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL E3', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Steve'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'pop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-12-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(250, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL N1', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Johan'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 10, 10, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'country');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-02 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(200, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL N2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 100, 47, 50);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'hip-hop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-03 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(300, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL N3', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 75, 67, 50);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'reggae');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-06 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(350, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id, person_id)
VALUES('SAL N4', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Paris'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 40, 38, 38);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'pop');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2022-01-09 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(250, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));
