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
FROM era_cdb_v3.letters
LEFT JOIN era_cdb_v3.locations AS SourceLoc ON SourceLoc.locations_id = letters.source_loc_id
LEFT JOIN era_cdb_v3.locations AS TargetLoc ON TargetLoc.locations_id = letters.target_loc_id
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND letters_id NOT LIKE '%ck2'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
