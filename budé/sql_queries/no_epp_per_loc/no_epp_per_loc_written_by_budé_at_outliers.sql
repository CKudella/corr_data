SELECT locations_name_modern,
       send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM letters,
     locations
WHERE source_loc_id = locations_id
  AND sender_id = 'budé_guillaume_viaf_105878228'
  AND letters_id NOT LIKE '%ck2'
  AND source_loc_id NOT LIKE 'unknown%'
  AND locations.locations_name_modern IN ('Paris',
                                          'Marly-la-Ville',
                                          'Dijon',
                                          'Lyon')
GROUP BY locations_name_modern,
         send_date_year1
