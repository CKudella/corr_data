SELECT name_in_edition
FROM wpirck_cdb_v1.correspondents
WHERE name_in_edition NOT IN
    (SELECT name_in_edition AS 'Correspondents who wrote to but did not receive any letters by Pirckheimer'
     FROM wpirck_cdb_v1.correspondents
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT recipient_id
          FROM wpirck_cdb_v1.letters
          WHERE recipient_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080')
     GROUP BY name_in_edition)
  AND name_in_edition NOT IN
    (SELECT name_in_edition
     FROM wpirck_cdb_v1.correspondents,
          letters
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT sender_id
          FROM wpirck_cdb_v1.letters
          WHERE sender_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080')
     GROUP BY name_in_edition)
