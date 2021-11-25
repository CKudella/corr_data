SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Erasmus sent to this modern state this year to mutual correspondents of his and Budé (excl. Budé)',
                send_date_year1
FROM era_cdb_v3.letters,
     era_cdb_v3.locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
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
