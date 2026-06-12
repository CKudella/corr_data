SELECT letter_language AS 'Letter Language',
       COUNT(*) AS 'Number of Letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM wpirck_cdb.letters
                WHERE letters_id NOT REGEXP 'ck[2-8]$'), 1) AS 'Percentage'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
GROUP BY letter_language
ORDER BY 'Percentage' DESC
