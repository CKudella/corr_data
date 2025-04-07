SELECT COUNT(*) AS 'Total number of letters sent by Pirckheimer'
FROM wpirck_cdb.letters
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
