SELECT name_in_edition AS 'Names of correspondents who wrote letters to Budé but did not receive any letters from him'
FROM bude_cdb.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM bude_cdb.letters)
GROUP BY name_in_edition
