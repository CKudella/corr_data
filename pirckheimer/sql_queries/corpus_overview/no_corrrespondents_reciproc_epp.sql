SELECT COUNT(correspondents_id) AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Pirckheimer'
 FROM wpirck_cdb.correspondents
 WHERE correspondents_id IN
     (SELECT DISTINCT sender_id
      FROM wpirck_cdb.letters
      WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
        AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
   AND correspondents_id IN
     (SELECT DISTINCT recipient_id
      FROM wpirck_cdb.letters
      WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
        AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
