SELECT send_date_year1 AS YEAR,
       COUNT(*) AS 'Number of letters sent to Pirckheimer this year'
FROM letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY send_date_year1
