SELECT name_in_edition AS 'Correspondents who received letters from Budé but did not write to him'
FROM bude_cdb.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM bude_cdb.letters)
GROUP BY name_in_edition
