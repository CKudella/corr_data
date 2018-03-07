SELECT name_in_edition
FROM correspondents
WHERE name_in_edition NOT IN
    (SELECT name_in_edition AS 'Correspondents who wrote to but did not receive any letters by Pirckheimer'
     FROM correspondents
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT recipient_id
          FROM letters
          WHERE recipient_id != 'pirckheimer_willibald_viaf_27173507')
     GROUP BY name_in_edition)
  AND name_in_edition NOT IN
    (SELECT name_in_edition
     FROM correspondents,
          letters
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT sender_id
          FROM letters
          WHERE sender_id != 'pirckheimer_willibald_viaf_27173507')
     GROUP BY name_in_edition)
