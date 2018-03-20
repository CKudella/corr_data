SELECT DISTINCT send_date_computable1,
                COUNT(*) AS NoEppSentFromPirck
FROM letters
WHERE sender_id ='pirckheimer_willibald_viaf_27173507'
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
GROUP BY send_date_computable1
