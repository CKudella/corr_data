SELECT COUNT(correspondents_id) AS 'Total number of correspondents in the dataset'
 FROM era_cdb_v3.correspondents
 WHERE correspondents_id NOT IN ('17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
