SELECT DISTINCT recipient_id,
                COUNT(DISTINCT target_loc_id) AS 'Number of locations this correspondent receives letters at'
FROM budé_cdb_v1.letters
GROUP BY recipient_id
ORDER BY recipient_id
