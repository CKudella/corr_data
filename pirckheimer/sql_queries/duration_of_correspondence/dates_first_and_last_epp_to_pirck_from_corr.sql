SELECT DISTINCT sender_id,
                MIN(send_date_computable1) AS 'First Letter to Pirckheimer',
                MAX(send_date_computable1) AS 'Last Letter to Pirckheimer'
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY sender_id
