SELECT DISTINCT letters.send_date_year1,
                COUNT(*) AS 'Total number of letters sent by Budé this year'
FROM budé_cdb_v1.letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND letters_id NOT LIKE '%ck2'
GROUP BY letters.send_date_year1
ORDER BY letters.send_date_year1 ASC
