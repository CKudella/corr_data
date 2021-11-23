SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT sender_id) AS 'Number of correspondents writing letters to Pirckheimer this year'
FROM letters
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
GROUP BY send_date_year1
