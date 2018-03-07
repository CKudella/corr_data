SELECT COUNT(*) AS 'Total number of letters in DB from the ALLEN edition excluding splits' from era_cdb_v3.letters WHERE letters.letter_no_in_edition LIKE '%[ALLEN]%' and letters_id NOT LIKE '%ck2'
