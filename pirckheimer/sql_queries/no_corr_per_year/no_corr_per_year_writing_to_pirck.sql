SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT sender_id) AS 'Number of correspondents writing letters to Pirckheimer this year'
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND sender_id != 'unnamed_person_viaf_not_applicable'
GROUP BY send_date_year1
