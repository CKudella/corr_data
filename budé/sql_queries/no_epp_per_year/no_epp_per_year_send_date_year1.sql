SELECT DISTINCT YEAR(send_date_computable1) AS 'Year',
       COUNT(*) AS 'Total number of letters sent this year'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY YEAR(send_date_computable1)
