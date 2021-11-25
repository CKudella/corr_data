SELECT BLET.source_loc_id AS 'Source',
       BLET.target_loc_id AS 'Target'
FROM budé_cdb_v1.letters AS BLET
WHERE BLET.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND BLET.letters_id NOT LIKE '%ck2'
  AND BLET.sender_id IN
    (SELECT X.correspondents_id
     FROM budé_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               budé_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id))
  AND BLET.source_loc_id NOT LIKE 'unknown%'
  AND BLET.target_loc_id NOT LIKE 'unknown%'
