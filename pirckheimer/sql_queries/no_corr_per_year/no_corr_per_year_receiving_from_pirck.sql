SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents Pirckheimer writes to this year'
FROM wpirck_cdb.letters
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
GROUP BY send_date_year1
