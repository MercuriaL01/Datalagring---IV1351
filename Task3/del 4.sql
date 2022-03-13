SELECT ensemble.lesson_id, ensemble.target_genre, to_char(scheduled_time_slot.lesson_time, 'day'),
CASE 
WHEN non_individual_lesson.lesson_number_of_places - non_individual_lesson.number_of_lesson_places_taken = 0
	THEN 'fully booked' 
WHEN non_individual_lesson.lesson_number_of_places - non_individual_lesson.number_of_lesson_places_taken = 1 OR non_individual_lesson.lesson_number_of_places - non_individual_lesson.number_of_lesson_places_taken = 2
	THEN '1-2 seats left' 
WHEN non_individual_lesson.lesson_number_of_places - non_individual_lesson.number_of_lesson_places_taken >= 3
	THEN 'more than 2 seats left' 
END AS "Places left"
FROM
(
scheduled_time_slot
INNER JOIN
ensemble
ON scheduled_time_slot.lesson_id = ensemble.lesson_id
INNER JOIN
non_individual_lesson
ON non_individual_lesson.lesson_id = ensemble.lesson_id
)
WHERE EXTRACT(week FROM scheduled_time_slot.lesson_time) = EXTRACT(week FROM current_date + INTERVAL '1 week') 	
ORDER BY ensemble.target_genre, EXTRACT(ISODOW FROM scheduled_time_slot.lesson_time) ASC