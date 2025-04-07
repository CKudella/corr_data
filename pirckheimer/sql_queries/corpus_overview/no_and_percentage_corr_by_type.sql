SELECT correspondents.type AS 'Correspondent Type',
       COUNT(correspondents_id) AS 'Number of correspondents',
       ROUND(COUNT(correspondents_id) * 100.0 /
               (SELECT COUNT(*)
                FROM wpirck_cdb.correspondents
                WHERE correspondents_id NOT IN ('d9233b24-a98c-4279-8065-e2ab70c0d080', 'be1dcbc4-3987-472a-b4a0-c3305ead139f')), 1) AS 'Percentage of Total Correspondents'
FROM wpirck_cdb.correspondents
WHERE correspondents_id NOT IN ('d9233b24-a98c-4279-8065-e2ab70c0d080',
                                'be1dcbc4-3987-472a-b4a0-c3305ead139f')
GROUP BY correspondents.type
