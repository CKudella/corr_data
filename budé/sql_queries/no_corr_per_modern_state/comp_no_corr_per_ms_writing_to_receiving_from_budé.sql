SELECT X.ModernState AS 'Modern State',
       A.NoCorrReceivingFromBudé AS 'Number of correspondents who received letters from Budé',
       B.NoCorrWritingToBudé AS 'Number of correspondents who wrote letters to Budé'
FROM
  (SELECT DISTINCT locations.locations_modern_state AS ModernState
   FROM bude_cdb.locations
   WHERE locations.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM bude_cdb.letters)
     OR locations.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM bude_cdb.letters)) AS X
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT recipient_id) AS NoCorrReceivingFromBudé
   FROM bude_cdb.letters,
        bude_cdb.locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id LIKE 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS A ON X.ModernState = A.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(DISTINCT sender_id) AS NoCorrWritingToBudé
   FROM bude_cdb.letters,
        bude_cdb.locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id LIKE 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS B ON X.ModernState = B.ModernState
