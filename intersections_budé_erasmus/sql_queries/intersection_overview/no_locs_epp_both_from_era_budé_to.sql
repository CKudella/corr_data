SELECT COUNT(BL.locations_id) AS 'Number of locations to which letters have been written by both Budé and Erasmus'
FROM budé_cdb_v1.locations AS BL
WHERE BL.locations_id IN
    (SELECT DISTINCT BLet.target_loc_id
     FROM budé_cdb_v1.letters AS BLet
     WHERE BLet.sender_id = 'budé_guillaume_viaf_105878228'
       AND BLet.target_loc_id NOT LIKE 'unknown%'
     GROUP BY BLet.target_loc_id)
  AND BL.locations_id IN
    (SELECT EL.locations_id
     FROM era_cdb_v3.locations AS EL
     WHERE EL.locations_id IN
         (SELECT DISTINCT ELet.target_loc_id
          FROM era_cdb_v3.letters AS ELet
          WHERE ELet.sender_id = 'erasmus_desiderius_viaf_95982394'
            AND ELet.target_loc_id NOT LIKE 'unknown%'
          GROUP BY ELet.target_loc_id))
