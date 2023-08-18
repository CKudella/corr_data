SELECT A.NoEPPfromPirck AS 'Number of letters written by Pirckheimer',
       ROUND(A.NoEPPfromPirck * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written by Pirckheimer of the total number of letters in the dataset',
       B.NoEPPtoPirck AS 'Number of letters written to Pirckheimer',
       ROUND(B.NoEPPtoPirck * 100.0 / C.TotalNoEPP, 1) AS 'Percentage of the number of letters written to Pirckheimer of the total number of letters in the dataset'
FROM
  (SELECT COUNT(*) AS NoEPPfromPirck
   FROM wpirck_cdb_v1.letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080') AS A,

  (SELECT COUNT(*) AS NoEPPtoPirck
   FROM wpirck_cdb_v1.letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080') AS B,

  (SELECT COUNT(*) AS 'TotalNoEPP'
   FROM wpirck_cdb_v1.letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8') AS C
