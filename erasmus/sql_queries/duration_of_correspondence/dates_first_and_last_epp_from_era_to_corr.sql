SELECT DISTINCT recipient_id,
                MIN(send_date_computable1) AS 'First letter from Erasmus',
                MAX(send_date_computable1) AS 'Last letter from Erasmus'
FROM era_cdb_v3.letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY recipient_id
