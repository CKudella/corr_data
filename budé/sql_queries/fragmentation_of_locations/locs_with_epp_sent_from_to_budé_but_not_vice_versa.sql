SELECT DISTINCT A.source_loc_id,
                SourceLoc.locations_name_modern AS SourceNameModern,
                SourceLoc.locations_lat AS SourceLAT,
                SourceLoc.locations_lng AS SourceLNG,
                A.target_loc_id,
                TargetLoc.locations_name_modern AS TargetNameModern,
                TargetLoc.locations_lat AS TargetLAT,
                TargetLoc.locations_lng AS TargetLNG
FROM bude_cdb.letters AS A
LEFT JOIN bude_cdb.locations AS SourceLoc ON SourceLoc.locations_id = A.source_loc_id
LEFT JOIN bude_cdb.locations AS TargetLoc ON TargetLoc.locations_id = A.target_loc_id
WHERE A.sender_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND A.source_loc_id NOT IN
    (SELECT DISTINCT B.target_loc_id
     FROM bude_cdb.letters AS B
     WHERE B.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
