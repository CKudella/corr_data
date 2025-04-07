SELECT COUNT(correspondents_id) AS 'Total number of correspondents in the dataset'
 FROM bude_cdb.correspondents
 WHERE correspondents_id NOT IN ('c0b89c75-45b8-4b04-bfd7-25bfe9ed040b',
                                 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
