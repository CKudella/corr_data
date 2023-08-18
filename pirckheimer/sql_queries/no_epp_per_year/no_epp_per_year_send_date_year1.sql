SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent this year'
FROM letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
GROUP BY send_date_year1
