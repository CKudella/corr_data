SELECT X.ModernState, X.COUNT AS 'Number of letters Erasmus sent to this modern state this year', Y.COUNT AS 'Number of letters sent from this modern state this year to Erasmus', X.send_date_year1 FROM
(SELECT DISTINCT locations_modern_state AS 'ModernState', COUNT(*) AS COUNT, send_date_year1 FROM letters, locations WHERE locations_id = target_loc_id AND letters_id NOT LIKE '%ck2' AND sender_id = 'erasmus_desiderius_viaf_95982394' GROUP BY locations_modern_state, send_date_year1 ORDER BY send_date_year1 ASC) AS X
INNER JOIN
(SELECT DISTINCT locations_modern_state AS 'ModernState', COUNT(*) AS COUNT, send_date_year1 FROM letters, locations WHERE locations_id = source_loc_id AND letters_id NOT LIKE '%ck2' AND recipient_id = 'erasmus_desiderius_viaf_95982394' GROUP BY locations_modern_state, send_date_year1 ORDER BY send_date_year1 ASC) AS Y
ON X.ModernState = Y.ModernState AND X.send_date_year1 = Y.send_date_year1 ORDER BY X.send_date_year1
