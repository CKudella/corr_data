SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.target_loc_id) AS 'Number of letters sent to this modern state by Erasmus to mutual correspondents of his and Pirckheimer (excl. Pirckheimer)'
FROM era_cdb_v3.letters
JOIN era_cdb_v3.locations ON locations.locations_id = letters.target_loc_id
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = 'erasmus_desiderius_viaf_95982394'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS P,
               era_cdb_v3.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id))
  AND recipient_id != 'pirckheimer_willibald_viaf_27173507'
GROUP BY locations_modern_state
ORDER BY COUNT(letters.target_loc_id) DESC
