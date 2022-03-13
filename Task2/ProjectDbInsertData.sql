INSERT INTO school_application(application_text, first_name, last_name, age, person_number, email)
VALUES('Hej jag vill vara med!' ,'Iley', 'Alvarez Funcke', 20, '20010212-1111', 'iley.alvarez.funcke@gmail.com');

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Iley', 'Alvarez Funcke', 20, '20010212-1111', 'iley.alvarez.funcke@gmail.com');

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Paris', 'Carbone', 18, '20030523-8888', 'parisc@kth.se');

INSERT INTO instrument(brand, type_of_instrument, quantity_in_stock)
VALUES('Yamaha', 'Piano', 10);

INSERT INTO skill_level(level)
VALUES('intermediate');

INSERT INTO lesson(location, skill_level_id, instrument_id)
VALUES('SAL B2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'));

INSERT INTO individual_lesson(lesson_id, individual_lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2021-11-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(150, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id)
VALUES('SAL B2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2021-12-11 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(250, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO lesson(location, skill_level_id, instrument_id)
VALUES('SAL B2', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'));

INSERT INTO non_individual_lesson(lesson_id, lesson_number_of_places, number_of_lesson_places_taken, minimum_number_of_students)
VALUES((SELECT MAX(lesson_id) FROM lesson), 30, 17, 10);

INSERT INTO ensemble(lesson_id, target_genre)
VALUES((SELECT MAX(lesson_id) FROM lesson), 'rock');

INSERT INTO scheduled_time_slot(lesson_id, lesson_time)
VALUES((SELECT MAX(lesson_id) FROM lesson), '2021-12-23 14:39:53.662522-05');

INSERT INTO pricing_scheme(price_amount, skill_level_id, lesson_id)
VALUES(277, (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT MAX(lesson_id) FROM lesson));

INSERT INTO transaction("time", to_or_from, lesson_id, person_id, discount, currency, skill_level_id)
VALUES(current_timestamp, cast(1 AS bit), (SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'), 0.25, 'sek', (SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'));

INSERT INTO student(person_id, number_of_instruments_rented, school_application_id)
VALUES((SELECT person_id FROM person WHERE first_name = 'Iley'), 1, (SELECT school_application_id FROM school_application WHERE first_name = 'Iley'));

INSERT INTO instructor(person_id, able_to_teach_ensembles, monthly_salary)
VALUES((SELECT person_id FROM person WHERE first_name = 'Paris'), cast(1 AS bit), 7777.77);

INSERT INTO lesson_receipt(transaction_id, "time", "text")
VALUES((SELECT transaction_id FROM transaction WHERE discount = 0.25), current_timestamp, 'bla bla this is a receipt');

INSERT INTO response_letter(response_answer, school_application_id)
VALUES('You got accepted!', (SELECT school_application_id FROM school_application WHERE first_name = 'Iley'));

INSERT INTO phone(phone_number, person_id)
VALUES('0708813096', (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO parent_contact_details(email, person_id)
VALUES('mamma@gmail.com', (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO sibling(person_number, person_id)
VALUES(20020628-7777, (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO monthly_fee(fee_cost, "date", person_id)
VALUES(300, '2022-01-01 14:39:53.662522-05', (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO persons_skill(skill_level_id, instrument_id, person_id)
VALUES((SELECT skill_level_id FROM skill_level WHERE level = 'intermediate'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO address(zip, city, street, person_id, apartment_number)
VALUES('11582', 'Stockholm', 'Odengatan 11', (SELECT person_id FROM person WHERE first_name = 'Iley'), '1234');

INSERT INTO booking(lesson_id, person_id)
VALUES((SELECT MAX(lesson_id) FROM lesson), (SELECT person_id FROM person WHERE first_name = 'Iley'));

INSERT INTO instructor_instrument(person_id, instrument_id)
VALUES((SELECT person_id FROM person WHERE first_name = 'Paris'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'));

INSERT INTO lease(end_of_lease_period, renting_fee, person_id, instrument_id, start_of_lease_period)
VALUES('2021-12-27 14:39:53.662522-05', 150, (SELECT person_id FROM person WHERE first_name = 'Iley'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), current_timestamp);

INSERT INTO lease_contract(lease_information_text, person_id, instrument_id, start_of_lease_period)
VALUES('This lease started on bla bla and endeded on bla bla its price is bla bla and its for person bla bla', (SELECT person_id FROM person WHERE first_name = 'Iley'), (SELECT instrument_id FROM instrument WHERE type_of_instrument = 'Piano'), (SELECT start_of_lease_period FROM lease WHERE renting_fee = 150));
