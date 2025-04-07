SELECT COUNT(*) AS 'Number of mutual correspondents of Budé and Erasmus'
FROM bude_cdb.correspondents AS B,
     era_cdb.correspondents AS E
WHERE B.correspondents_id = E.correspondents_id
  AND B.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                  '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                  'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
  AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                  '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                  'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
