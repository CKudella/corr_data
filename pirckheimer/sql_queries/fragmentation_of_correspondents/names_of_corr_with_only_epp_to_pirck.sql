SELECT name_in_edition AS 'Correspondents who wrote to but did not receive any letters by Pirckheimer'
FROM wpirck_cdb.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM wpirck_cdb.letters)
GROUP BY name_in_edition
