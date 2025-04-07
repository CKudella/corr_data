SELECT COUNT(*) AS 'Number of mutual correspondents of Pirckheimer and Erasmus'
FROM era_cdb.correspondents AS X
WHERE X.correspondents_id IN
    (SELECT P.correspondents_id
     FROM wpirck_cdb.correspondents AS P,
          era_cdb.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'd9233b24-a98c-4279-8065-e2ab70c0d080'))
