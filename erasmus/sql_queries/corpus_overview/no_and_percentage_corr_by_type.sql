SELECT correspondents.type AS 'Correspondent Type',
       COUNT(correspondents_id) AS 'Number of correspondents',
       ROUND(COUNT(correspondents_id) * 100.0 /
               (SELECT COUNT(*)
                FROM era_cdb.correspondents
                WHERE correspondents_id NOT IN ('17c580aa-3ba7-4851-8f26-9b3a0ebeadbf', 'be1dcbc4-3987-472a-b4a0-c3305ead139f')), 1) AS 'Percentage of Total Correspondents'
FROM era_cdb.correspondents
WHERE correspondents_id NOT IN ('17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                'be1dcbc4-3987-472a-b4a0-c3305ead139f')
GROUP BY correspondents.type
