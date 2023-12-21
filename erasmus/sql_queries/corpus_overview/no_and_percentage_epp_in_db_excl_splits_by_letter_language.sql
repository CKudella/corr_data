SELECT letter_language AS 'Letter Language',
       COUNT(*) AS 'Number of Letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM era_cdb_v3.letters
                WHERE letters_id NOT LIKE '%ck2'), 1) AS 'Percentage'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY letter_language
ORDER BY 'Percentage' DESC
