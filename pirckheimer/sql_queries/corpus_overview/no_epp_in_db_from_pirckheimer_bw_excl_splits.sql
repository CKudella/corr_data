SELECT COUNT(*) AS 'Total number of letters in DB that are part of the Pirckheimer BW edition exluding splits'
FROM wpirck_cdb.letters
WHERE (letters_id LIKE 'wpirck_bw%'
       OR letter_no_in_edition LIKE '%[Pirckheimer BW]%')
  AND letters_id NOT REGEXP 'ck[2-8]$'
ORDER BY letters_id
