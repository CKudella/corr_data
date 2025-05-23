SELECT A.correspondents_id,
       A.name_in_edition,
       B.NoEPPfromEra,
       C.NoEPPtoEra
FROM
  (SELECT DISTINCT correspondents_id, name_in_edition
   FROM era_cdb.correspondents) AS A
LEFT JOIN
  (SELECT DISTINCT recipient_id,
                   COUNT(*) 'NoEPPfromEra'
   FROM era_cdb.letters
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY recipient_id
   ORDER BY COUNT('NoEPPfromEra') DESC) AS B ON A.correspondents_id = B.recipient_id
LEFT JOIN
  (SELECT DISTINCT sender_id,
                   COUNT(*) 'NoEPPtoEra'
   FROM era_cdb.letters
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY sender_id
   ORDER BY COUNT('NoEPPtoEra') DESC) AS C ON A.correspondents_id = C.sender_id
