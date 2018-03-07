SELECT COUNT(*) AS 'Total number of letters in the Budé DB'
FROM letters
WHERE letters_id NOT LIKE '%ck2'
