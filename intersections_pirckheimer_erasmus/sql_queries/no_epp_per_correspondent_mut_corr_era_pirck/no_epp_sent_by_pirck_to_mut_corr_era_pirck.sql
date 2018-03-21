SELECT DISTINCT PL.recipient_id,
                COUNT(*) AS 'Number of letters sent by Pirckheimer per mutual correspondent'
FROM wpirck_cdb_v1.letters AS PL,

  (SELECT *
   FROM era_cdb_v3.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT P.correspondents_id
        FROM wpirck_cdb_v1.correspondents AS P,
             era_cdb_v3.correspondents AS E
        WHERE P.correspondents_id = E.correspondents_id
          AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
          AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable')) AS MC
WHERE PL.recipient_id = MC.correspondents_id
  AND sender_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY PL.recipient_id
ORDER BY COUNT(*) DESC
