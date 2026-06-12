SELECT COUNT(*) AS 'Number of letters in Pirckheimer DB'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
