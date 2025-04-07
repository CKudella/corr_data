SELECT COUNT(PL.locations_id) AS 'Number of locations from which letters have been sent both to Pirckheimer and Erasmus'
FROM wpirck_cdb.locations AS PL
WHERE PL.locations_id IN
    (SELECT DISTINCT PLet.source_loc_id
     FROM wpirck_cdb.letters AS PLet
     WHERE PLet.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND PLet.source_loc_id NOT LIKE 'unknown%'
     GROUP BY PLet.source_loc_id)
  AND PL.locations_id IN
    (SELECT EL.locations_id
     FROM era_cdb.locations AS EL
     WHERE EL.locations_id IN
         (SELECT DISTINCT ELet.source_loc_id
          FROM era_cdb.letters AS ELet
          WHERE ELet.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
            AND ELet.source_loc_id NOT LIKE 'unknown%'
          GROUP BY ELet.source_loc_id))
