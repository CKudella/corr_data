SELECT COUNT(*) AS 'Total number of letters in DB that are not part of the Pirckheimer BW edition exluding splits'
FROM wpirck_cdb.letters
WHERE letters_id NOT LIKE 'wpirck_bw%'
  AND letter_no_in_edition NOT LIKE '%[Pirckheimer BW]%'
  AND letters_id NOT REGEXP 'ck[2-8]$'
ORDER BY letters_id
