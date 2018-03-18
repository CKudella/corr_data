SELECT name_in_edition
FROM budé_cdb_v1.correspondents
WHERE name_in_edition NOT IN
    (SELECT name_in_edition AS 'Names of correspondents who have both written letters to Budé and received letters from him'
     FROM correspondents
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT recipient_id
          FROM letters
          WHERE recipient_id != 'budé_guillaume_viaf_105878228')
     GROUP BY name_in_edition)
  AND name_in_edition NOT IN
    (SELECT name_in_edition
     FROM correspondents,
          letters
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT sender_id
          FROM letters
          WHERE sender_id != 'budé_guillaume_viaf_105878228')
     GROUP BY name_in_edition)
