SELECT name_in_edition
FROM budé_cdb_v1.correspondents
WHERE name_in_edition NOT IN
    (SELECT name_in_edition AS 'Names of correspondents who have both written letters to Budé and received letters from him'
     FROM budé_cdb_v1.correspondents
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT recipient_id
          FROM budé_cdb_v1.letters
          WHERE recipient_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
     GROUP BY name_in_edition)
  AND name_in_edition NOT IN
    (SELECT name_in_edition
     FROM budé_cdb_v1.correspondents,
          letters
     WHERE correspondents.correspondents_id NOT IN
         (SELECT DISTINCT sender_id
          FROM budé_cdb_v1.letters
          WHERE sender_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
     GROUP BY name_in_edition)
