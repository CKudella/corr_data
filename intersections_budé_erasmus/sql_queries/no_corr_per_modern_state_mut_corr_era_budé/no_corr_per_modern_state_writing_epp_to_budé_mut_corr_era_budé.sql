SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of mutual correspondents of Erasmus and Budé who wrote from this modern state letters to Budé'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id LIKE 'budé_guillaume_viaf_105878228'
  AND sender_id IN
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
ORDER BY COUNT(DISTINCT sender_id) DESC
