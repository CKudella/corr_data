SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Budé sent to this modern state this year to mutual correspondents of his and Erasmus (excl. Erasmus)',
                send_date_year1
FROM bude_cdb.letters,
     bude_cdb.locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM bude_cdb.correspondents AS B,
          era_cdb.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'))
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
