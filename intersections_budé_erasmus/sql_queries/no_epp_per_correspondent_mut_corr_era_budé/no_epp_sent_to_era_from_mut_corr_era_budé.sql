SELECT DISTINCT EL.sender_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent to Erasmus per mutual correspondent'
FROM era_cdb.letters AS EL, era_cdb.correspondents AS EC,

  (SELECT *
   FROM era_cdb.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT B.correspondents_id
        FROM bude_cdb.correspondents AS B,
             era_cdb.correspondents AS E
        WHERE B.correspondents_id = E.correspondents_id
          AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
          AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS MC
WHERE EL.sender_id = MC.correspondents_id AND EC.correspondents_id = EL.sender_id
  AND sender_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY EL.sender_id
ORDER BY COUNT(*) DESC
