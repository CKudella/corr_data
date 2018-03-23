SELECT locations_id AS 'Id',
       locations_name_modern,
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM budé_cdb_v1.locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE recipient_id = 'budé_guillaume_viaf_105878228'
       AND source_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'budé_guillaume_viaf_105878228'
       AND sender_id IN
         (SELECT X.correspondents_id
          FROM budé_cdb_v1.correspondents AS X
          WHERE X.correspondents_id IN
              (SELECT E.correspondents_id
               FROM era_cdb_v3.correspondents AS E,
                    budé_cdb_v1.correspondents AS B
               WHERE E.correspondents_id = B.correspondents_id))
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id
