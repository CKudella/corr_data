SELECT name_in_edition AS 'Names of correspondents who wrote letters to Erasmus but did not receive any letters from him'
FROM era_cdb.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb.letters)
GROUP BY name_in_edition
