SELECT send_date_year1 AS YEAR,
       COUNT(*) AS 'Number of letters sent by Pirckheimer per year'
FROM letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND sender_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY send_date_year1
