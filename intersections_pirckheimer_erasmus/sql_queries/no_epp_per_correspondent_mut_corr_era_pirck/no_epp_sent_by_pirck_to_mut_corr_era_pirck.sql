SELECT DISTINCT PL.recipient_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Pirckheimer per mutual correspondent'
FROM wpirck_cdb_v1.letters AS PL, era_cdb_v3.correspondents AS EC,

  (SELECT *
   FROM era_cdb_v3.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT P.correspondents_id
        FROM wpirck_cdb_v1.correspondents AS P,
             era_cdb_v3.correspondents AS E
        WHERE P.correspondents_id = E.correspondents_id
          AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
          AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS MC
WHERE PL.recipient_id = MC.correspondents_id AND EC.correspondents_id = PL.recipient_id
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY PL.recipient_id
ORDER BY COUNT(*) DESC
