SELECT COUNT(correspondents_id) AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Pirckheimer'
FROM wpirck_cdb_v1.correspondents
WHERE correspondents_id IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND sender_id != 'unnamed_person_viaf_not_applicable'
       AND correspondents.type = 'individual')
  AND correspondents_id IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
       AND recipient_id != 'unnamed_person_viaf_not_applicable'
       AND correspondents.type = 'individual')
