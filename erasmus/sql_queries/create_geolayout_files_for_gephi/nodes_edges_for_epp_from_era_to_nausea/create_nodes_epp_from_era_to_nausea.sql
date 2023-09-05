SELECT locations_id AS 'Id',
       locations_name_modern,
       locations_lat,
       locations_lng,
       locations_ll_combined
FROM era_cdb_v3.locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
       AND recipient_id = 'e1d61ad4-bfa4-4202-97c4-29ef8cf66541')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND recipient_id = 'e1d61ad4-bfa4-4202-97c4-29ef8cf66541')
GROUP BY locations_id
