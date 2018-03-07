SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Budé sent to this modern state this year',
                send_date_year1
FROM letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND sender_id = 'budé_guillaume_viaf_105878228'
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
