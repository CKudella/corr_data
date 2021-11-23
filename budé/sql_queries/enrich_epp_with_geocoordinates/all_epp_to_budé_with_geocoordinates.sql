SELECT letters_id,
       sender_id,
       recipient_id,
       send_date_computable1,
       source_loc_id,
       SourceLoc.locations_lat AS SourceLAT,
       SourceLoc.locations_lng AS SourceLNG,
       target_loc_id,
       TargetLoc.locations_lat AS TargetLAT,
       TargetLoc.locations_lng AS TargetLNG
FROM budé_cdb_v1.letters
LEFT JOIN budé_cdb_v1.locations AS SourceLoc ON SourceLoc.locations_id = letters.source_loc_id
LEFT JOIN budé_cdb_v1.locations AS TargetLoc ON TargetLoc.locations_id = letters.target_loc_id
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
