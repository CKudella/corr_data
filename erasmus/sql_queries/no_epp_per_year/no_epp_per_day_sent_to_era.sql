SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentToEra
FROM letters
WHERE recipient_id ='erasmus_desiderius_viaf_95982394'
  AND letters_id NOT LIKE '%ck2'
GROUP BY send_date_computable1
