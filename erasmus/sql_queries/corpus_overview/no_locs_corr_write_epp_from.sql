SELECT DISTINCT sender_id,
                COUNT(DISTINCT source_loc_id) AS 'Number of locations this correspondent writes letters from'
FROM era_cdb.letters
GROUP BY sender_id
ORDER BY sender_id
