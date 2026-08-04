SELECT YEAR(send_date_computable1) AS 'Year',
       COUNT(*) AS 'Number of letters sent by Pirckheimer this year'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY YEAR(send_date_computable1)
