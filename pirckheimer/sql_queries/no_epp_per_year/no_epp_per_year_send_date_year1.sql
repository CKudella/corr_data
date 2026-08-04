SELECT DISTINCT YEAR(send_date_computable1) AS 'Year',
       COUNT(*) AS 'Total number of letters sent this year'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1) ASC
