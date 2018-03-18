SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents Budé writes to this year'
FROM budé_cdb_v1.letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND recipient_id != 'unnamed_person_viaf_not_applicable'
GROUP BY send_date_year1
