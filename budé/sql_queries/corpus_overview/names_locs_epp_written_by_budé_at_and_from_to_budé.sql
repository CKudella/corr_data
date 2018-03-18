SELECT locations.locations_name_modern AS 'Names of the locations from which Budé has both sent letters and received letters from'
FROM budé_cdb_v1.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
  AND locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE recipient_id = 'budé_guillaume_viaf_105878228'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
