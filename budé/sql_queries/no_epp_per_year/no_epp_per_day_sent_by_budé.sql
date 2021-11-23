SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentFromBudé
FROM budé_cdb_v1.letters
WHERE sender_id ='c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND letters_id NOT LIKE '%ck2'
GROUP BY send_date_computable1
