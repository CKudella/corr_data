SELECT letters_id,
       sender_id,
       recipient_id,
       send_date_computable1,
       source_loc_id,
       SourceLoc.locations_lat AS SourceLAT,
       SourceLoc.locations_lng AS SourceLNG,
       target_loc_id,
       TargetLoc.locations_lat AS TargetLAT,
       TargetLoc.locations_lng AS TargetLNG,
       CONCAT('LINESTRING (',SourceLoc.locations_lng,' ', SourceLoc.locations_lat,' , ',TargetLoc.locations_lng,' ', TargetLoc.locations_lat,')',' |',letters_id) AS GEOM
FROM budé_cdb_v1.letters AS L
LEFT JOIN budé_cdb_v1.locations AS SourceLoc ON SourceLoc.locations_id = L.source_loc_id
LEFT JOIN budé_cdb_v1.locations AS TargetLoc ON TargetLoc.locations_id = L.target_loc_id
WHERE L.sender_id = 'budé_guillaume_viaf_105878228'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable'))
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
