SELECT COUNT(*) AS 'Total number of letters in DB that are part of the Pirckheimer BW edition exluding splits'
FROM wpirck_cdb_v1.letters
WHERE (letters_id LIKE 'wpirck_bw%'
       OR letter_no_in_edition LIKE '%[Pirckheimer BW]%')
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
ORDER BY letters_id
