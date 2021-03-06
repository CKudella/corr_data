SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents (type: individual) who have written letters to Budé'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.correspondents
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
  AND sender_id != 'unnamed_person_viaf_not_applicable'
  AND correspondents.type = 'individual'
