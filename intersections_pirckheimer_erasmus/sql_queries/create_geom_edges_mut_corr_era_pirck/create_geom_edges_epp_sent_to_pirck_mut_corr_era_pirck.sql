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
       CONCAT('LINESTRING (', SourceLoc.locations_lng, ' ', SourceLoc.locations_lat, ', ', TargetLoc.locations_lng, ' ', TargetLoc.locations_lat, ')') AS GEOM
FROM wpirck_cdb_v1.letters as L
LEFT JOIN wpirck_cdb_v1.locations AS SourceLoc ON SourceLoc.locations_id = L.source_loc_id
LEFT JOIN wpirck_cdb_v1.locations AS TargetLoc ON TargetLoc.locations_id = L.target_loc_id
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS P,
          era_cdb_v3.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080'))
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
