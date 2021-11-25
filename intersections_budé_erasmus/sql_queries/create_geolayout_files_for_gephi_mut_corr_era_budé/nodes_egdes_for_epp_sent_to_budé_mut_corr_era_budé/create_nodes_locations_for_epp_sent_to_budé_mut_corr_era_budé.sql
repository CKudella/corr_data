SELECT BLOC.locations_id AS 'Id',
       BLOC.locations_name_modern AS 'Label',
       BLOC.locations_modern_state,
       BLOC.locations_modern_province,
       BLOC.locations_lat,
       BLOC.locations_lng
FROM budé_cdb_v1.locations AS BLOC
WHERE BLOC.locations_id IN
    (SELECT DISTINCT BLETA.source_loc_id
     FROM budé_cdb_v1.letters BLETA
     WHERE BLETA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND BLETA.sender_id IN
         (SELECT X.correspondents_id
          FROM budé_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    budé_cdb_v1.correspondents AS B
               WHERE E.correspondents_id = B.correspondents_id))
       AND BLETA.letters_id NOT LIKE '%ck2'
       AND BLETA.source_loc_id NOT LIKE 'unknown%'
       AND BLETA.target_loc_id NOT LIKE 'unknown%')
  OR BLOC.locations_id IN
    (SELECT DISTINCT BLETB.target_loc_id
     FROM budé_cdb_v1.letters BLETB
     WHERE BLETB.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND BLETB.sender_id IN
         (SELECT X.correspondents_id
          FROM budé_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    budé_cdb_v1.correspondents AS B
               WHERE E.correspondents_id = B.correspondents_id))
       AND BLETB.letters_id NOT LIKE '%ck2'
       AND BLETB.source_loc_id NOT LIKE 'unknown%'
       AND BLETB.target_loc_id NOT LIKE 'unknown%')
GROUP BY BLOC.locations_id
