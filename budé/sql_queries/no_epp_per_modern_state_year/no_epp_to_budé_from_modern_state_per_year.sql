SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state to Budé this year',
                send_date_year1
FROM bude_cdb.letters,
     bude_cdb.locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
