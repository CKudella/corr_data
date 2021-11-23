SELECT A.NoCorrOnlyEppFromPirck AS 'Total number of correspondents for whom the dataset contains only letters written to them from Pirckheimer but not vice versa',
       ROUND(A.NoCorrOnlyEppFromPirck * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written to them from Pirck but not vice versa of the total number of correspondents',
       B.NoCorrOnlyEpptoPirck AS 'Total number of correspondents for whom the dataset contains only letters written from them to Pirckheimer but not vice versa',
       ROUND(B.NoCorrOnlyEpptoPirck * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written from them to Pirckheimer but not vice versa of the total number of correspondents',
       C.NoCorrReciproc AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Pirckheimer',
       ROUND(C.NoCorrReciproc * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains a reciprocal correspondence with Pirckheimer of the total number of correspondents'
FROM
  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEppFromPirck
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoPirck
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id NOT IN ('d9233b24-a98c-4279-8065-e2ab70c0d080',
                                   'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS D
