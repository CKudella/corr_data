SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.source_loc_id) AS 'Number of letters sent from this modern state to Pirckheimer from mutual correspondents of his and Erasmus (incl. Erasmus)'
FROM wpirck_cdb_v1.letters
JOIN wpirck_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS P,
               era_cdb_v3.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id
            AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
))
GROUP BY locations_modern_state
ORDER BY COUNT(letters.source_loc_id) DESC
