SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents (type: individual) who have received letters by Budé'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.correspondents
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND recipient_id != 'unnamed_person_viaf_not_applicable'
  AND correspondents.type = 'individual'
