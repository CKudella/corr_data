SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT sender_id) AS 'Number of correspondents writing letters to Budé this year'
FROM budé_cdb_v1.letters
WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
  AND sender_id != 'unnamed_person_viaf_not_applicable'
GROUP BY send_date_year1
