SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Pirckheimer sent to this modern state this year',
                send_date_year1
FROM wpirck_cdb_v1.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
