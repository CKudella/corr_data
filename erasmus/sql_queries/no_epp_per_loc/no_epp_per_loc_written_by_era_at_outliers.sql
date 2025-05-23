SELECT locations_name_modern,
       send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM era_cdb.letters,
     locations
WHERE source_loc_id = locations_id
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
  AND locations.locations_name_modern IN ('Basel',
                                          'Freiburg im Breisgau',
                                          'Leuven',
                                          'Antwerp',
                                          'Paris')
GROUP BY locations_name_modern,
         send_date_year1
