SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents Pirckheimer writes to this year'
FROM letters
WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
  AND recipient_id != 'unnamed_person_viaf_not_applicable'
GROUP BY send_date_year1
