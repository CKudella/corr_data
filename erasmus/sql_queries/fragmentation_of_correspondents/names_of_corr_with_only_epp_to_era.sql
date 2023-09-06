SELECT name_in_edition AS 'Names of correspondents who wrote letters to Erasmus but did not receive any letters from him'
FROM era_cdb_v3.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb_v3.letters)
GROUP BY name_in_edition
