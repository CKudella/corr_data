SELECT COUNT(locations.locations_id) AS 'Number of locations to which letters have been sent by Pirckheimer'
FROM wpirck_cdb.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM wpirck_cdb.letters
     WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND target_loc_id NOT LIKE 'unknown%'
     GROUP BY target_loc_id)
