SELECT COUNT(correspondents_id) AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Budé'
 FROM bude_cdb_v1.correspondents
 WHERE correspondents_id IN
     (SELECT DISTINCT sender_id
      FROM bude_cdb_v1.letters
      WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
        AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
   AND correspondents_id IN
     (SELECT DISTINCT recipient_id
      FROM bude_cdb_v1.letters
      WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
        AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
