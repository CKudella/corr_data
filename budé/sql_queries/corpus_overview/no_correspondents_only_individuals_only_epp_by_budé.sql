SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) for whom the dataset contains only letters written to them from Budé but not vice versa'
FROM budé_cdb_v1.correspondents
WHERE correspondents_id IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND recipient_id != 'unnamed_person_viaf_not_applicable'
       AND correspondents.type = 'individual')
  AND correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'budé_guillaume_viaf_105878228'
       AND sender_id != 'unnamed_person_viaf_not_applicable'
       AND correspondents.type = 'individual')
