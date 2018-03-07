SELECT COUNT(DISTINCT name_in_edition) AS 'Total number of correspondents (type: individual) who wrote to Budé but did not receive letters by him'
FROM correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters)
  AND correspondents.type = 'individual'
