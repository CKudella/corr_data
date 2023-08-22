SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Pirckheimer sent to this modern state this year to mutual correspondents of his and Erasmus (excl. Erasmus)',
                send_date_year1
FROM wpirck_cdb_v1.letters,
     wpirck_cdb_v1.locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND recipient_id IN
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
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
