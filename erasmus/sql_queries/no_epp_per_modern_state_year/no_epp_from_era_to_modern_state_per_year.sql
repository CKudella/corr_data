SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Erasmus sent to this modern state this year',
                send_date_year1
FROM era_cdb.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
