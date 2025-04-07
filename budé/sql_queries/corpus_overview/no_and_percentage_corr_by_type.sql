SELECT correspondents.type AS 'Correspondent Type',
       COUNT(correspondents_id) AS 'Number of correspondents',
       ROUND(COUNT(correspondents_id) * 100.0 /
               (SELECT COUNT(*)
                FROM bude_cdb.correspondents
                WHERE correspondents_id NOT IN ('c0b89c75-45b8-4b04-bfd7-25bfe9ed040b', 'be1dcbc4-3987-472a-b4a0-c3305ead139f')), 1) AS 'Percentage of Total Correspondents'
FROM bude_cdb.correspondents
WHERE correspondents_id NOT IN ('c0b89c75-45b8-4b04-bfd7-25bfe9ed040b',
                                'be1dcbc4-3987-472a-b4a0-c3305ead139f')
GROUP BY correspondents.type
