SELECT A.NoEPPfromEra AS 'Number of letters written by Erasmus',
       ROUND(A.NoEPPfromEra * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written by Erasmus of the total number of letters in the dataset',
       B.NoEPPtoEra AS 'Number of letters written to Erasmus',
       ROUND(B.NoEPPtoEra * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written to Erasmus of the total number of letters in the dataset'
FROM
  (SELECT COUNT(*) AS NoEPPfromEra
   FROM era_cdb_v3.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf') AS A,

  (SELECT COUNT(*) AS NoEPPtoEra
   FROM era_cdb_v3.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf') AS B,

  (SELECT COUNT(*) AS 'TotalNoEPP'
   FROM era_cdb_v3.letters
   WHERE letters_id NOT LIKE '%ck2') AS C
