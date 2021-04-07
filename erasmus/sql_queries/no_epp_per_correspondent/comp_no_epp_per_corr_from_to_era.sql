SELECT A.correspondents_id,
       B.NoEPPfromEra,
       C.NoEPPtoEra
FROM
  (SELECT DISTINCT correspondents_id
   FROM correspondents) AS A
LEFT JOIN
  (SELECT DISTINCT recipient_id,
                   COUNT(*) 'NoEPPfromEra'
   FROM letters
   WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY recipient_id
   ORDER BY COUNT('NoEPPfromEra') DESC) AS B ON A.correspondents_id = B.recipient_id
LEFT JOIN
  (SELECT DISTINCT sender_id,
                   COUNT(*) 'NoEPPtoEra'
   FROM letters
   WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY sender_id
   ORDER BY COUNT('NoEPPtoEra') DESC) AS C ON A.correspondents_id = C.sender_id
