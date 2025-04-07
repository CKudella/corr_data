SELECT letter_type_x_to_x,
       COUNT(*) AS 'Number of letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM era_cdb.letters
                WHERE letters_id NOT LIKE '%ck2'), 1) AS 'Percentage'
FROM era_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY letter_type_x_to_x
ORDER BY 'Percentage' DESC
