SELECT name_in_edition AS 'Names of correspondents who received letters from Erasmus but did not write to him'
FROM era_cdb_v3.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb_v3.letters)
GROUP BY name_in_edition
