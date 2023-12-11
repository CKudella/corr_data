SELECT locations_name_modern,
       send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM wpirck_cdb_v1.letters,
     locations
WHERE source_loc_id = locations_id
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
  AND locations.locations_name_modern LIKE 'Nuremberg'
GROUP BY locations_name_modern,
         send_date_year1
