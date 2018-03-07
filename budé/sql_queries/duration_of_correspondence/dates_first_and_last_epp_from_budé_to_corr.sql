SELECT DISTINCT recipient_id,
                MIN(send_date_computable1) AS 'First Letter From Budé',
                MAX(send_date_computable1) AS 'Last Letter From Budé'
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
GROUP BY recipient_id
