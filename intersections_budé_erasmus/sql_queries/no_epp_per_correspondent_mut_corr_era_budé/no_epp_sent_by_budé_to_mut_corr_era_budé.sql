SELECT DISTINCT BL.recipient_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Budé per mutual correspondent'
FROM bude_cdb.letters AS BL, era_cdb.correspondents AS EC,

  (SELECT *
   FROM era_cdb.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT B.correspondents_id
        FROM bude_cdb.correspondents AS B,
             era_cdb.correspondents AS E
        WHERE B.correspondents_id = E.correspondents_id
          AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
          AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS MC
WHERE BL.recipient_id = MC.correspondents_id AND EC.correspondents_id = BL.recipient_id
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY BL.recipient_id
ORDER BY COUNT(*) DESC
