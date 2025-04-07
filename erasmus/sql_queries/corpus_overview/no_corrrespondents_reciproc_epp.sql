SELECT COUNT(correspondents_id) AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus'
 FROM era_cdb.correspondents
 WHERE correspondents_id IN
     (SELECT DISTINCT sender_id
      FROM era_cdb.letters
      WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
        AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
   AND correspondents_id IN
     (SELECT DISTINCT recipient_id
      FROM era_cdb.letters
      WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
        AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
