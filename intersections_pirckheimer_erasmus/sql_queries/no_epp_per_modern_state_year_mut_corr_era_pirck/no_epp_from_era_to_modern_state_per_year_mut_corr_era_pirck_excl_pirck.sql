SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Erasmus sent to this modern state this year to mutual correspondents of his and Pirckheimer (excl. Pirckheimer)',
                send_date_year1
FROM era_cdb.letters,
     era_cdb.locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb.correspondents AS P,
          era_cdb.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080'))
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
