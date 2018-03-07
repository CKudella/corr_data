SELECT COUNT(DISTINCT name_in_edition) AS 'Total number of correspondents (type: individual) who wrote letters to Erasmus but did not receive any letters from him'
FROM era_cdb_v3.correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters)
  AND correspondents.type = 'individual'
