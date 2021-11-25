SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent to Pirckheimer this year to mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM wpirck_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS P,
          era_cdb_v3.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080'))
GROUP BY send_date_year1
