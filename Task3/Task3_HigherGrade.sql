CREATE TABLE historical."lesson"
(
    "lesson_id" int NOT NULL PRIMARY KEY,
    "location" varchar(500),
    "skill_level" varchar(500) NOT NULL,
    "instrument" varchar(500),
    "lesson_number_of_places" int,
    "number_of_lesson_places_taken" int,
    "minimum_number_of_students" int,
    "target_genre" varchar(500),
    "lesson_time" timestamp(6),
    "price_amount" int,
    "lesson_type" varchar(50)
);

CREATE TABLE historical."student"
(
    "student_id" int NOT NULL PRIMARY KEY,
    "first_name" varchar(500),
    "last_name" varchar(500),
    "age" int,
    "person_number" varchar(500) UNIQUE NOT NULL,
    "email" varchar(500) UNIQUE
);

CREATE TABLE historical."lesson_student"
(
    "lesson_id" int NOT NULL REFERENCES "lesson",
    "student_id" int NOT NULL REFERENCES "student",
    PRIMARY KEY("lesson_id", "student_id")
);
