SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent this year'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
GROUP BY send_date_year1
