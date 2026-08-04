SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Pirckheimer sent to this modern state this year',
                YEAR(send_date_computable1) AS 'Year'
FROM wpirck_cdb.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state,
         YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1) ASC
