CREATE VIEW instructor_check AS
SELECT person.first_name, person.last_name, lessons.* FROM
(
	(
		SELECT person_id, COUNT(lesson_id) AS number_of_lessons
		FROM
		(
			SELECT lesson.lesson_id, individual_lesson_time AS lesson_time, person_id
			FROM lesson INNER JOIN individual_lesson
			ON lesson.lesson_id = individual_lesson.lesson_id
			UNION
			SELECT lesson.lesson_id, lesson_time, person_id
			FROM lesson INNER JOIN scheduled_time_slot
			ON lesson.lesson_id = scheduled_time_slot.lesson_id
		) AS times
		WHERE EXTRACT(MONTH FROM times.lesson_time) = EXTRACT(MONTH FROM current_date)
		AND EXTRACT(YEAR FROM times.lesson_time) = EXTRACT(YEAR FROM current_date)
		GROUP BY person_id
	) AS lessons
	INNER JOIN
	person
	ON person.person_id = lessons.person_id
)
WHERE
--In line below you specify the minimum number of lessons
number_of_lessons >= 1
ORDER BY number_of_lessons DESC
