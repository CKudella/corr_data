SELECT X.ModernState, X.COUNT AS 'Number of letters Budé sent to this modern state this year', Y.COUNT AS 'Number of letters sent from this modern state this year to Budé', X.send_date_year1 FROM
(SELECT DISTINCT locations_modern_state AS 'ModernState', COUNT(*) AS COUNT, send_date_year1 FROM letters, locations WHERE locations_id = target_loc_id AND letters_id NOT LIKE '%ck2' AND sender_id = 'budé_guillaume_viaf_105878228' GROUP BY locations_modern_state, send_date_year1 ORDER BY send_date_year1 ASC) AS X
INNER JOIN
(SELECT DISTINCT locations_modern_state AS 'ModernState', COUNT(*) AS COUNT, send_date_year1 FROM letters, locations WHERE locations_id = source_loc_id AND letters_id NOT LIKE '%ck2' AND recipient_id = 'budé_guillaume_viaf_105878228' GROUP BY locations_modern_state, send_date_year1 ORDER BY send_date_year1 ASC) AS Y
ON X.ModernState = Y.ModernState AND X.send_date_year1 = Y.send_date_year1 ORDER BY X.send_date_year1
