SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromBudé,
       C.NoEppSentToBudé
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   YEAR(AL.send_date_computable1) AS 'Year'
   FROM bude_cdb.locations AS AA,
        bude_cdb.letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM bude_cdb.letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM bude_cdb.letters AS AC)
   GROUP BY YEAR(AL.send_date_computable1),
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromBudé,
                   YEAR(send_date_computable1) As 'Year'
   FROM bude_cdb.letters,
        bude_cdb.locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state,
            YEAR(send_date_computable1)
   ORDER BY YEAR(send_date_computable1) ASC) AS B ON B.ModernState = A.ModernState
AND B.Year = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToBudé,
                    YEAR(send_date_computable1) AS 'Year'
   FROM bude_cdb.letters,
        bude_cdb.locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state,
             YEAR(send_date_computable1)
   ORDER BY  YEAR(send_date_computable1) ASC) AS C ON C.ModernState = A.ModernState
AND C.Year = A.Year
