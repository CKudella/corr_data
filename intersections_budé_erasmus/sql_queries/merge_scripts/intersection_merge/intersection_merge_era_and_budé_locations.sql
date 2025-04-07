SELECT
LOC.locations_id AS 'Id',
LOC.locations_name_modern AS 'Label',
LOC.locations_modern_state,
LOC.locations_modern_province,
LOC.locations_lat AS 'Latitude',
LOC.locations_lng AS 'Longitude',
LOC.locations_ll_combined
FROM
  (SELECT *
   FROM era_cdb_v3.locations
   UNION ALL
     (SELECT *
      FROM bude_cdb_v1.locations AS B
      WHERE B.locations_id NOT IN
          (SELECT E.locations_id
           FROM era_cdb_v3.locations AS E))) AS LOC
WHERE LOC.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM
       (SELECT *
        FROM era_cdb_v3.letters
        UNION ALL
          (SELECT *
           FROM bude_cdb_v1.letters
           WHERE letters_id NOT LIKE '%_cwe_%')) AS L
     WHERE L.sender_id IN
         (SELECT X.correspondents_id
          FROM era_cdb_v3.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT B.correspondents_id
               FROM bude_cdb_v1.correspondents AS B,
                    era_cdb_v3.correspondents AS E
               WHERE B.correspondents_id = E.correspondents_id
                 AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
                 AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
       AND L.recipient_id IN
         (SELECT X.correspondents_id
          FROM era_cdb_v3.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT B.correspondents_id
               FROM bude_cdb_v1.correspondents AS B,
                    era_cdb_v3.correspondents AS E
               WHERE B.correspondents_id = E.correspondents_id
                 AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
                 AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')))
  OR LOC.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM
       (SELECT *
        FROM era_cdb_v3.letters
        UNION ALL
          (SELECT *
           FROM bude_cdb_v1.letters
           WHERE letters_id NOT LIKE '%_cwe_%')) AS L
     WHERE L.sender_id IN
         (SELECT X.correspondents_id
          FROM era_cdb_v3.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT B.correspondents_id
               FROM bude_cdb_v1.correspondents AS B,
                    era_cdb_v3.correspondents AS E
               WHERE B.correspondents_id = E.correspondents_id
                 AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
                 AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
       AND L.recipient_id IN
         (SELECT X.correspondents_id
          FROM era_cdb_v3.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT B.correspondents_id
               FROM bude_cdb_v1.correspondents AS B,
                    era_cdb_v3.correspondents AS E
               WHERE B.correspondents_id = E.correspondents_id
                 AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
                 AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')))
