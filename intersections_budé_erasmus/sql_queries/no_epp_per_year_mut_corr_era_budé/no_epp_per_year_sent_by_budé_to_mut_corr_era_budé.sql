SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent by Budé this year to mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
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
GROUP BY send_date_year1
