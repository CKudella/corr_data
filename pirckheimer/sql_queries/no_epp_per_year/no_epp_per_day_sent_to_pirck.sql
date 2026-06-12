SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentToPirck
FROM wpirck_cdb.letters
WHERE recipient_id ='d9233b24-a98c-4279-8065-e2ab70c0d080'
  AND letters_id NOT REGEXP 'ck[2-8]$'
GROUP BY send_date_computable1
