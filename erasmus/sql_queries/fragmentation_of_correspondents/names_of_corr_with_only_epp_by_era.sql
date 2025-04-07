SELECT name_in_edition AS 'Names of correspondents who received letters from Erasmus but did not write to him'
FROM era_cdb.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb.letters)
GROUP BY name_in_edition
