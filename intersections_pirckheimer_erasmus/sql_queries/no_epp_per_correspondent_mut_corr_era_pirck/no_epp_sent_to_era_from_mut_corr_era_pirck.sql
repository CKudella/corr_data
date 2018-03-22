SELECT DISTINCT EL.sender_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent to Erasmus per mutual correspondent'
FROM era_cdb_v3.letters AS EL, era_cdb_v3.correspondents AS EC,

  (SELECT *
   FROM era_cdb_v3.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT P.correspondents_id
        FROM wpirck_cdb_v1.correspondents AS P,
             era_cdb_v3.correspondents AS E
        WHERE P.correspondents_id = E.correspondents_id
          AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
          AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable')) AS MC
WHERE EL.sender_id = MC.correspondents_id AND EC.correspondents_id = EL.sender_id
  AND sender_id != 'erasmus_desiderius_viaf_95982394'
GROUP BY EL.sender_id
ORDER BY COUNT(*) DESC
