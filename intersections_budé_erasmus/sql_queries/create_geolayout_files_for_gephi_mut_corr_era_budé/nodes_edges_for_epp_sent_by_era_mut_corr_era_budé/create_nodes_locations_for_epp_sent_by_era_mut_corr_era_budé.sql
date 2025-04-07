SELECT ELOC.locations_id AS 'Id',
       ELOC.locations_name_modern AS 'Label',
       ELOC.locations_modern_state,
       ELOC.locations_modern_province,
       ELOC.locations_lat,
       ELOC.locations_lng
FROM era_cdb_v3.locations AS ELOC
WHERE ELOC.locations_id IN
    (SELECT DISTINCT ELETA.source_loc_id
     FROM era_cdb_v3.letters AS ELETA
     WHERE ELETA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND ELETA.recipient_id IN
         (SELECT X.correspondents_id
          FROM bude_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    bude_cdb_v1.correspondents AS B
               WHERE E.correspondents_id = B.correspondents_id))
       AND ELETA.source_loc_id NOT LIKE 'unknown%'
       AND ELETA.target_loc_id NOT LIKE 'unknown%')
  OR ELOC.locations_id IN
    (SELECT DISTINCT ELETB.target_loc_id
     FROM era_cdb_v3.letters AS ELETB
     WHERE ELETB.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND ELETB.recipient_id IN
         (SELECT X.correspondents_id
          FROM bude_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    bude_cdb_v1.correspondents AS B
               WHERE E.correspondents_id = B.correspondents_id))
       AND ELETB.source_loc_id NOT LIKE 'unknown%'
       AND ELETB.target_loc_id NOT LIKE 'unknown%')
GROUP BY ELOC.locations_id
