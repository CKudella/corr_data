SELECT A.NoCorrOnlyEppFromEra AS 'Total number of correspondents for whom the dataset contains only letters written to them by Erasmus but not vice versa',
       ROUND(A.NoCorrOnlyEppFromEra * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written to them by Erasmus but not vice versa of the total number of correspondents',
       B.NoCorrOnlyEpptoEra AS 'Total number of correspondents for whom the dataset contains only letters written by them to Erasmus but not vice versa',
       ROUND(B.NoCorrOnlyEpptoEra * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written by them to Erasmus but not vice versa of the total number of correspondents',
       C.NoCorrReciproc AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus',
       ROUND(C.NoCorrReciproc * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus of the total number of correspondents'
FROM
  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEppFromEra
   FROM era_cdb.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM era_cdb.letters
        WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM era_cdb.letters
        WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoEra
   FROM era_cdb.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM era_cdb.letters
        WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM era_cdb.letters
        WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM era_cdb.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM era_cdb.letters
        WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM era_cdb.letters
        WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM era_cdb.correspondents
   WHERE correspondents_id NOT IN ('17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                   'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS D
