SELECT name_in_edition
FROM wpirck_cdb_v1.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM wpirck_cdb_v1.letters)
GROUP BY name_in_edition
