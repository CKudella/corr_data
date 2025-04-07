SELECT letters_id,
       source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM era_cdb.letters
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
  AND recipient_id = 'e1d61ad4-bfa4-4202-97c4-29ef8cf66541'
