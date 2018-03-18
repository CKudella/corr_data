SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentToBudé
FROM budé_cdb_v1.letters
WHERE recipient_id ='budé_guillaume_viaf_105878228'
  AND letters_id NOT LIKE '%ck2'
GROUP BY send_date_computable1
