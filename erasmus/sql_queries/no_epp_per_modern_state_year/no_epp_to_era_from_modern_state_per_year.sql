SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state to Erasmus this year',
                send_date_year1
FROM era_cdb.letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
