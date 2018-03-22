SELECT DISTINCT BL.recipient_id, EC.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Budé per mutual correspondent'
FROM budé_cdb_v1.letters AS BL, era_cdb_v3.correspondents AS EC,

  (SELECT *
   FROM era_cdb_v3.correspondents AS X
   WHERE X.correspondents_id IN
       (SELECT B.correspondents_id
        FROM budé_cdb_v1.correspondents AS B,
             era_cdb_v3.correspondents AS E
        WHERE B.correspondents_id = E.correspondents_id
          AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
          AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable')) AS MC
WHERE BL.recipient_id = MC.correspondents_id
  AND sender_id = 'budé_guillaume_viaf_105878228'
GROUP BY BL.recipient_id
ORDER BY COUNT(*) DESC
