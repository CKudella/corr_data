SELECT DISTINCT YEAR(send_date_computable1),
       COUNT(*) AS 'Total number of letters sent this year'
FROM era_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1) ASC
