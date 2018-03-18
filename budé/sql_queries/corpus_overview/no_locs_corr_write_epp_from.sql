SELECT DISTINCT sender_id,
                COUNT(DISTINCT source_loc_id) AS 'Number of locations this correspondent writes letters from'
FROM budé_cdb_v1.letters
GROUP BY sender_id
ORDER BY sender_id
