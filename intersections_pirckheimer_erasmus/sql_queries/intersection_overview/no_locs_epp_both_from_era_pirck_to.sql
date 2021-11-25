SELECT COUNT(PL.locations_id) AS 'Number of locations to which letters have been written by both Pirckheimer and Erasmus'
FROM wpirck_cdb_v1.locations AS PL
WHERE PL.locations_id IN
    (SELECT DISTINCT PLet.target_loc_id
     FROM wpirck_cdb_v1.letters AS PLet
     WHERE PLet.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND PLet.target_loc_id NOT LIKE 'unknown%'
     GROUP BY PLet.target_loc_id)
  AND PL.locations_id IN
    (SELECT EL.locations_id
     FROM era_cdb_v3.locations AS EL
     WHERE EL.locations_id IN
         (SELECT DISTINCT ELet.target_loc_id
          FROM era_cdb_v3.letters AS ELet
          WHERE ELet.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
            AND ELet.target_loc_id NOT LIKE 'unknown%'
          GROUP BY ELet.target_loc_id))
