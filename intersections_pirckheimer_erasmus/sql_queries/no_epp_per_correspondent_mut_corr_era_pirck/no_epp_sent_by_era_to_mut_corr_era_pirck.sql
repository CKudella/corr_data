SELECT DISTINCT EL.recipient_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Erasmus per mututal correspondent'
FROM era_cdb.letters AS EL, era_cdb.correspondents AS EC,

  (SELECT *
   FROM era_cdb.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT P.correspondents_id
        FROM wpirck_cdb.correspondents AS P,
             era_cdb.correspondents AS E
        WHERE P.correspondents_id = E.correspondents_id
          AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
          AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS MC
WHERE EL.recipient_id = MC.correspondents_id AND EC.correspondents_id = EL.recipient_id
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY EL.recipient_id
ORDER BY COUNT(*) DESC
