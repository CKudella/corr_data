SELECT locations_name_modern,
       send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM bude_cdb_v1.letters,
     locations
WHERE source_loc_id = locations_id
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
  AND locations.locations_name_modern IN ('Paris',
                                          'Marly-la-Ville',
                                          'Dijon',
                                          'Lyon')
GROUP BY locations_name_modern,
         send_date_year1
