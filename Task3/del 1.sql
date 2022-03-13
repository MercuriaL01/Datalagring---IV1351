--To change to another year simply replace all occurances of 2022 to the year that should be checked

SELECT 
2022 AS "year",
CASE 
      WHEN individualmonth IS NOT null THEN TO_CHAR ( TO_DATE (individualmonth::text, 'MM'), 'Month' )
      WHEN non_ensemble_group_month IS NOT null THEN TO_CHAR ( TO_DATE (non_ensemble_group_month::text, 'MM'), 'Month' )
	  ELSE  TO_CHAR ( TO_DATE (ensemble_month::text, 'MM'), 'Month' )
END AS "month", 
coalesce(individual_number_of_lessons, 0) + coalesce(non_ensemble_group_number_of_lessons, 0) + coalesce(ensemble_number_of_lessons, 0) 
AS total_number_of_lesson,
coalesce(individual_number_of_lessons, 0) AS individual_number_of_lessons,
coalesce(non_ensemble_group_number_of_lessons, 0) AS non_ensemble_group_number_of_lessons,
coalesce(ensemble_number_of_lessons, 0) AS ensemble_number_of_lessons
FROM
(
	(SELECT EXTRACT(MONTH FROM individual_lesson_time) AS individualmonth, COUNT(lesson_id) AS individual_number_of_lessons FROM individual_lesson 
	GROUP BY EXTRACT(YEAR FROM individual_lesson_time), EXTRACT(MONTH FROM individual_lesson_time) 
	HAVING EXTRACT(YEAR FROM individual_lesson_time) = 2022)
	AS individual_months

	FULL OUTER JOIN    

	(SELECT EXTRACT(MONTH FROM lesson_time) AS non_ensemble_group_month, COUNT(lesson_id) AS non_ensemble_group_number_of_lessons 
	FROM 
	(
		SELECT scheduled_time_slot.* FROM 
		scheduled_time_slot
		LEFT JOIN 
		ensemble
		ON scheduled_time_slot.lesson_id = ensemble.lesson_id
		WHERE ensemble.lesson_id is null
	
	) AS non_ensemble_group
	GROUP BY EXTRACT(YEAR FROM lesson_time), EXTRACT(MONTH FROM lesson_time) 
	HAVING EXTRACT(YEAR FROM lesson_time) = 2022)
	AS non_ensemble_group_months
	ON individual_months.individualmonth =  non_ensemble_group_months.non_ensemble_group_month

	FULL OUTER JOIN

	(SELECT EXTRACT(MONTH FROM lesson_time) AS ensemble_month, COUNT(lesson_id) AS ensemble_number_of_lessons 
	FROM 
	(
		SELECT scheduled_time_slot.* FROM
		scheduled_time_slot
		INNER JOIN
		ensemble
		ON scheduled_time_slot.lesson_id = ensemble.lesson_id
	) AS ensembles
	GROUP BY EXTRACT(YEAR FROM lesson_time), EXTRACT(MONTH FROM lesson_time) 
	HAVING EXTRACT(YEAR FROM lesson_time) = 2022)
	AS ensemble_months
	ON non_ensemble_group_months.non_ensemble_group_month = ensemble_months.ensemble_month
	)
AS all_lessons

ORDER BY coalesce(individualmonth, non_ensemble_group_month, ensemble_month)
ASC



