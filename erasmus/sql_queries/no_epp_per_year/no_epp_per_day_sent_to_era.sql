SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentToEra
FROM letters
WHERE recipient_id ='17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND letters_id NOT LIKE '%ck2'
GROUP BY send_date_computable1
