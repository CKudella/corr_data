SELECT letters_id,
       source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
  AND source_loc_id NOT LIKE 'unknown%'
  AND recipient_id = 'nausea_friedrich_viaf_248203874'
