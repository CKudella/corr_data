SELECT letter_type_genus,
       COUNT(*) AS 'Number of letters',
       ROUND(COUNT(*) * 100.0 /
               (SELECT COUNT(*)
                FROM wpirck_cdb_v1.letters
                WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'), 1) AS 'Percentage'
FROM wpirck_cdb_v1.letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
GROUP BY letter_type_genus
ORDER BY 'Percentage' DESC
