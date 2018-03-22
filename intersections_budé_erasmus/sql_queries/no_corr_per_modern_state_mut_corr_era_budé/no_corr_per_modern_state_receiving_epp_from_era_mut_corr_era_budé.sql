SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT recipient_id) AS 'Number of mutual correspondents of Erasmus and Budé who received letters from Erasmus in this modern state'
FROM era_cdb_v3.letters,
     era_cdb_v3.locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id LIKE 'erasmus_desiderius_viaf_95982394'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228'))
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT recipient_id) DESC
