SELECT letter_type_x_to_x,
       COUNT(*) AS 'Number of letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM wpirck_cdb.letters
                WHERE letters_id NOT REGEXP 'ck[2-8]$'), 1) AS 'Percentage'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
GROUP BY letter_type_x_to_x
ORDER BY 'Percentage' DESC
