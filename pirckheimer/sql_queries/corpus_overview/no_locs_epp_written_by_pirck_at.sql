SELECT COUNT(DISTINCT letters.source_loc_id) AS 'Total number of locations from which letters have been sent by Pirckheimer'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
