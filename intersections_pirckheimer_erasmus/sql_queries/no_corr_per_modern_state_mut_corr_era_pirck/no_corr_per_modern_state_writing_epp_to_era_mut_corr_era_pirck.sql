SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of mutual correspondents of Erasmus and Pirckheimer who wrote from this modern state letters to Erasmus'
FROM era_cdb_v3.letters,
     era_cdb_v3.locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id LIKE 'erasmus_desiderius_viaf_95982394'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS P,
          era_cdb_v3.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507'))
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT sender_id) DESC
