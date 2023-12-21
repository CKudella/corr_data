SELECT letter_type_genus,
       COUNT(*) AS 'Number of letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM budé_cdb_v1.letters
                WHERE letters_id NOT LIKE '%ck2'), 1) AS 'Percentage'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY letter_type_genus
ORDER BY 'Percentage' DESC
