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
FROM wpirck_cdb.letters
LEFT JOIN wpirck_cdb.locations AS SourceLoc ON SourceLoc.locations_id = letters.source_loc_id
LEFT JOIN wpirck_cdb.locations AS TargetLoc ON TargetLoc.locations_id = letters.target_loc_id
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
