SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.source_loc_id) AS 'Number of letters sent from this modern state to Budé from mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM budé_cdb_v1.letters
JOIN budé_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id))
  AND sender_id != 'erasmus_desiderius_viaf_95982394'
GROUP BY locations_modern_state
ORDER BY COUNT(letters.source_loc_id) DESC
