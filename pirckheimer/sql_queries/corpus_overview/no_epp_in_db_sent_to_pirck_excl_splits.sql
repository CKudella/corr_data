SELECT COUNT(*) AS 'Total number of letters sent to Pirckheimer'
FROM wpirck_cdb.letters
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND letters_id NOT REGEXP 'ck[2-8]$'
