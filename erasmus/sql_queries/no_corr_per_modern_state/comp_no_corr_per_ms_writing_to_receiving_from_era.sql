SELECT X.ModernState AS 'Modern State',
       A.NoCorrReceivingFromEra AS 'Number of correspondents who received letters from Erasmus',
       B.NoCorrWritingToEra AS 'Number of correspondents who wrote letters to Erasmus'
FROM
  (SELECT DISTINCT locations.locations_modern_state AS ModernState
   FROM locations
   WHERE locations.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM letters)
     OR locations.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM letters)) AS X
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT recipient_id) AS NoCorrReceivingFromEra
   FROM letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id LIKE 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS A ON X.ModernState = A.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT sender_id) AS NoCorrWritingToEra
   FROM letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id LIKE 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS B ON X.ModernState = B.ModernState
