INSERT INTO school_application(application_text, first_name, last_name, age, person_number, email)
VALUES('Hej jag vill vara med!' ,'Linus', 'Karlberg', 20, '20010412-1111', 'linus.karlberg@gmail.com');

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('Linus', 'Karlberg', 20, '20010412-1111', 'linus.karlberg@gmail.com');

INSERT INTO school_application(application_text, first_name, last_name, age, person_number, email)
VALUES('Hej jag vill vara med!' ,'George', 'Potter', 21, '20020212-1111', 'george.potter@gmail.com');

INSERT INTO person(first_name, last_name, age, person_number, email)
VALUES('George', 'Potter', 21, '20000212-1111', 'george.potter@hotmail.com');

INSERT INTO student(person_id, number_of_instruments_rented, school_application_id)
VALUES((SELECT person_id FROM person WHERE first_name = 'Linus'), 0, (SELECT school_application_id FROM school_application WHERE first_name = 'Linus'));

INSERT INTO student(person_id, number_of_instruments_rented, school_application_id)
VALUES((SELECT person_id FROM person WHERE first_name = 'George'), 0, (SELECT school_application_id FROM school_application WHERE first_name = 'George'));

INSERT INTO instrument_type(type_of_instrument)
VALUES('Bass');

INSERT INTO instrument_type(type_of_instrument)
VALUES('Microphone');

INSERT INTO instrument_type(type_of_instrument)
VALUES('Triangle');

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Sauter', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Piano'), 250);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Fender', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Bass'), 300);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Sennheiser', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Microphone'), 200);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Isosceles', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Triangle'), 10000);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Yamaha', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Piano'), 200);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Ibanez', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Bass'), 200);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Shure', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Microphone'), 200);

INSERT INTO instrument(brand, instrument_type_id, price)
VALUES('Chukwagon', (SELECT instrument_type_id FROM instrument_type WHERE type_of_instrument = 'Triangle'), 100);
