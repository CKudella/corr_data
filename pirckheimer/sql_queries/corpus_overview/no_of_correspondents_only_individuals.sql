SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) in the dataset'
FROM wpirck_cdb_v1.correspondents
WHERE correspondents_id NOT IN ('d9233b24-a98c-4279-8065-e2ab70c0d080',
                                'be1dcbc4-3987-472a-b4a0-c3305ead139f')
  AND correspondents.type = 'individual'
