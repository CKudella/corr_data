SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state to Budé this year',
                send_date_year1
FROM budé_cdb_v1.letters,
     budé_cdb_v1.locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
