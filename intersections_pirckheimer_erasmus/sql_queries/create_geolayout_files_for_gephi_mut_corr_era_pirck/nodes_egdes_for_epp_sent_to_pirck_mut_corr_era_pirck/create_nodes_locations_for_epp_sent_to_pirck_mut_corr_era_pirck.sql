SELECT PLOC.locations_id AS 'Id',
       PLOC.locations_name_modern AS 'Label',
       PLOC.locations_modern_state,
       PLOC.locations_modern_province,
       PLOC.locations_lat,
       PLOC.locations_lng
FROM wpirck_cdb_v1.locations AS PLOC
WHERE PLOC.locations_id IN
    (SELECT DISTINCT PLETA.source_loc_id
     FROM wpirck_cdb_v1.letters PLETA
     WHERE PLETA.recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND PLETA.sender_id IN
         (SELECT X.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    wpirck_cdb_v1.correspondents AS P
               WHERE E.correspondents_id = P.correspondents_id))
       AND PLETA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
       AND PLETA.source_loc_id NOT LIKE 'unknown%'
       AND PLETA.target_loc_id NOT LIKE 'unknown%')
  OR PLOC.locations_id IN
    (SELECT DISTINCT PLETB.target_loc_id
     FROM wpirck_cdb_v1.letters PLETB
     WHERE PLETB.recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND PLETB.sender_id IN
         (SELECT X.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    wpirck_cdb_v1.correspondents AS P
               WHERE E.correspondents_id = P.correspondents_id))
       AND PLETB.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
       AND PLETB.source_loc_id NOT LIKE 'unknown%'
       AND PLETB.target_loc_id NOT LIKE 'unknown%')
GROUP BY PLOC.locations_id
