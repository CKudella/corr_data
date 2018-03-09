SELECT A.NoEPPfromBudé AS 'Number of letters written by Budé',
       ROUND(A.NoEPPfromBudé * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written by Budé of the total number of letters in the dataset',
       B.NoEPPtoBudé AS 'Number of letters written to Budé',
       ROUND(B.NoEPPtoBudé * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written to Budé of the total number of letters in the dataset'
FROM
  (SELECT COUNT(*) AS NoEPPfromBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'budé_guillaume_viaf_105878228') AS A,

  (SELECT COUNT(*) AS NoEPPtoBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'budé_guillaume_viaf_105878228') AS B,

  (SELECT COUNT(*) AS 'TotalNoEPP'
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2') AS C
