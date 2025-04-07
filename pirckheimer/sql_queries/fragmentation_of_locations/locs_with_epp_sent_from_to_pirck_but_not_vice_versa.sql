SELECT DISTINCT A.source_loc_id,
                SourceLoc.locations_name_modern AS SourceNameModern,
                SourceLoc.locations_lat AS SourceLAT,
                SourceLoc.locations_lng AS SourceLNG,
                A.target_loc_id,
                TargetLoc.locations_name_modern AS TargetNameModern,
                TargetLoc.locations_lat AS TargetLAT,
                TargetLoc.locations_lng AS TargetLNG
FROM wpirck_cdb.letters AS A
LEFT JOIN locations AS SourceLoc ON SourceLoc.locations_id = A.source_loc_id
LEFT JOIN locations AS TargetLoc ON TargetLoc.locations_id = A.target_loc_id
WHERE A.sender_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND A.source_loc_id NOT IN
    (SELECT DISTINCT B.target_loc_id
     FROM wpirck_cdb.letters AS B
     WHERE B.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080')
