SELECT X.ModernState AS 'Modern State',
       A.NoCorrReceivingFromPirck AS 'Number of correspondents who received letters from Pirckheimer',
       B.NoCorrWritingToPirck AS 'Number of correspondents who wrote letters to Pirckheimer'
FROM
  (SELECT DISTINCT locations.locations_modern_state AS ModernState
   FROM wpirck_cdb_v1.locations
   WHERE locations.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM wpirck_cdb_v1.letters)
     OR locations.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM wpirck_cdb_v1.letters)) AS X
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT recipient_id) AS NoCorrReceivingFromPirck
   FROM wpirck_cdb_v1.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id LIKE 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS A ON X.ModernState = A.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT sender_id) AS NoCorrWritingToPirck
   FROM wpirck_cdb_v1.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id LIKE 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS B ON X.ModernState = B.ModernState
