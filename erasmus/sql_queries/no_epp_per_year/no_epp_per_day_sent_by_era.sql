SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentFromEra
FROM era_cdb.letters
WHERE sender_id ='17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND letters_id NOT LIKE '%ck2'
GROUP BY send_date_computable1
ORDER BY send_date_computable1 ASC
