CREATE TABLE "school_application"
(
    "school_application_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "application_text" varchar(5000),
    "first_name" varchar(500),
    "last_name" varchar(500),
    "age" INT,
    "person_number" varchar(13) NOT NULL,
    "email" varchar(500)
);

CREATE TABLE "person"
(
    "person_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "first_name" varchar(500),
    "last_name" varchar(500),
    "age" int,
    "person_number" varchar(13) UNIQUE NOT NULL,
    "email" varchar(500) UNIQUE
);

CREATE TABLE "instrument"
(
    "instrument_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "brand" varchar(500),
    "type_of_instrument" varchar(500),
    "quantity_in_stock" int
);

CREATE TABLE "skill_level"
(
    "skill_level_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "level" varchar(500)
);

CREATE TABLE "student"
(
    "person_id" int PRIMARY KEY REFERENCES "person",
    "number_of_instruments_rented" int,
    "school_application_id" int NOT NULL REFERENCES "school_application"
);

CREATE TABLE "instructor"
(
    "person_id" int PRIMARY KEY REFERENCES "person",
    "able_to_teach_ensembles" bit(1),
    "monthly_salary" float(2)
);

CREATE TABLE "lesson"
(
    "lesson_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "location" varchar(500),
    "skill_level_id" int NOT NULL REFERENCES "skill_level",
    "instrument_id" int NOT NULL REFERENCES "instrument",
    "person_id" int NOT NULL REFERENCES "instructor"
);

CREATE TABLE "transaction"
(
    "transaction_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "time" timestamp(6),
    "to_or_from" bit(1),
    "lesson_id" int NOT NULL REFERENCES "lesson",
    "person_id" int NOT NULL REFERENCES "person",
    "discount" float(10),
    "currency" varchar(500),
    "skill_level_id" int NOT NULL REFERENCES "skill_level"
);

CREATE TABLE "lesson_receipt"
(
    "transaction_id" int PRIMARY KEY REFERENCES "transaction",
    "time" timestamp(6),
    "text" varchar(500)
);

CREATE TABLE "non_individual_lesson"
(
    "lesson_id" int PRIMARY KEY REFERENCES "lesson",
    "lesson_number_of_places" int,
    "number_of_lesson_places_taken" int,
    "minimum_number_of_students" int
);

CREATE TABLE "individual_lesson"
(
    "lesson_id" int PRIMARY KEY REFERENCES "lesson",
    "individual_lesson_time" timestamp(6)
);

CREATE TABLE "scheduled_time_slot"
(
    "lesson_id" int PRIMARY KEY REFERENCES "lesson",
    "lesson_time" timestamp(6)
);

CREATE TABLE "ensemble"
(
    "lesson_id" int PRIMARY KEY REFERENCES "lesson",
    "target_genre" varchar(500) NOT NULL
);

CREATE TABLE "response_letter"
(
    "response_answer" varchar(5000) NOT NULL,
    "school_application_id" int NOT NULL REFERENCES "school_application",
    PRIMARY KEY("response_answer", "school_application_id")
);

CREATE TABLE "phone"
(
    "phone_number" varchar(500) UNIQUE NOT NULL,
    "person_id" INT NOT NULL REFERENCES "person",
    PRIMARY KEY("phone_number", "person_id")
);

CREATE TABLE "parent_contact_details"
(
    "email" varchar(500) NOT NULL,
    "person_id" INT NOT NULL REFERENCES "person",
    PRIMARY KEY("email", "person_id")
);

CREATE TABLE "sibling"
(
    "person_number" varchar(13) NOT NULL,
    "person_id" INT NOT NULL REFERENCES "person",
    PRIMARY KEY("person_number", "person_id")
);

CREATE TABLE "monthly_fee"
(
    "fee_cost" int,
    "date" timestamp(6) NOT NULL,
    "person_id" INT NOT NULL REFERENCES "person",
    PRIMARY KEY("date", "person_id")
);

CREATE TABLE "persons_skill"
(
    "skill_level_id" int NOT NULL REFERENCES "skill_level",
    "instrument_id" int NOT NULL REFERENCES "instrument",
    "person_id" int NOT NULL REFERENCES "person",
    PRIMARY KEY("instrument_id", "person_id")
);

CREATE TABLE "address"
(
    "zip" varchar(500),
    "city" varchar(500),
    "street" varchar(500) NOT NULL,
    "person_id" int NOT NULL REFERENCES "person",
    "apartment_number" varchar(500) NOT NULL,
    PRIMARY KEY("street", "person_id", "apartment_number")
);

CREATE TABLE "booking"
(
    "lesson_id" int NOT NULL REFERENCES "lesson" ON DELETE CASCADE,
    "person_id" int NOT NULL REFERENCES "person",
    PRIMARY KEY("lesson_id", "person_id")
);

CREATE TABLE "instructor_instrument"
(
    "person_id" int NOT NULL REFERENCES "person",
    "instrument_id" int NOT NULL REFERENCES "instrument",
    PRIMARY KEY("person_id", "instrument_id")
);

CREATE TABLE "pricing_scheme"
(
    "price_amount" int,
    "skill_level_id" int NOT NULL REFERENCES "skill_level",
    "lesson_id" int NOT NULL REFERENCES "lesson" ON DELETE CASCADE,
    PRIMARY KEY("skill_level_id", "lesson_id")
);

CREATE TABLE "lease"
(
    "end_of_lease_period" timestamp(6),
    "renting_fee" int,
    "person_id" int NOT NULL REFERENCES "person",
    "instrument_id" int NOT NULL REFERENCES "instrument",
    "start_of_lease_period" timestamp(6) NOT NULL,
    PRIMARY KEY("person_id", "instrument_id", "start_of_lease_period")
);

CREATE TABLE "lease_contract"
(
    "lease_information_text" varchar(5000),
    "person_id" int NOT NULL,
    "instrument_id" int NOT NULL,
    "start_of_lease_period" timestamp(6) NOT NULL,
    PRIMARY KEY("person_id", "instrument_id", "start_of_lease_period"),
    FOREIGN KEY("person_id", "instrument_id", "start_of_lease_period") REFERENCES "lease" ("person_id", "instrument_id", "start_of_lease_period")
);
