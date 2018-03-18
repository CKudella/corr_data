SELECT name_in_edition AS 'Correspondents who received letters from Budé but did not write to him'
FROM budé_cdb_v1.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters)
GROUP BY name_in_edition
