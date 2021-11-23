SELECT locations.locations_name_modern
FROM budé_cdb_v1.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM budé_cdb_v1.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
  AND locations.locations_id NOT IN
    (SELECT DISTINCT source_loc_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
