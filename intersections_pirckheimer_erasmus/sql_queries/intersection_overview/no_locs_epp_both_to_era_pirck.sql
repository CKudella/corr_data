SELECT COUNT(PL.locations_id) AS 'Number of locations from which letters have been sent both to Pirckheimer and Erasmus'
FROM wpirck_cdb_v1.locations AS PL
WHERE PL.locations_id IN
    (SELECT DISTINCT PLet.source_loc_id
     FROM wpirck_cdb_v1.letters AS PLet
     WHERE PLet.recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND PLet.source_loc_id NOT LIKE 'unknown%'
     GROUP BY PLet.source_loc_id)
  AND PL.locations_id IN
    (SELECT EL.locations_id
     FROM era_cdb_v3.locations AS EL
     WHERE EL.locations_id IN
         (SELECT DISTINCT ELet.source_loc_id
          FROM era_cdb_v3.letters AS ELet
          WHERE ELet.recipient_id = 'erasmus_desiderius_viaf_95982394'
            AND ELet.source_loc_id NOT LIKE 'unknown%'
          GROUP BY ELet.source_loc_id))
