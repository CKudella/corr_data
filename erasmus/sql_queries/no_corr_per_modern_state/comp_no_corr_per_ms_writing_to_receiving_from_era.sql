SELECT X.ModernState AS 'Modern State',
       A.NoCorrReceivingFromEra AS 'Number of correspondents who received letters from Erasmus',
       B.NoCorrWritingToEra AS 'Number of correspondents who wrote letters to Erasmus'
FROM
  (SELECT DISTINCT locations.locations_modern_state AS ModernState
   FROM era_cdb_v3.locations
   WHERE locations.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM era_cdb_v3.letters)
     OR locations.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM era_cdb_v3.letters)) AS X
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT recipient_id) AS NoCorrReceivingFromEra
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id LIKE '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS A ON X.ModernState = A.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT sender_id) AS NoCorrWritingToEra
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id LIKE '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS B ON X.ModernState = B.ModernState
