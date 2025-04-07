SELECT A.NoCorrOnlyEppFromBudé AS 'Total number of correspondents for whom the dataset contains only letters written to them by Budé but not vice versa',
       ROUND(A.NoCorrOnlyEppFromBudé * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written to them By Budé but not vice versa of the total number of correspondents',
       B.NoCorrOnlyEpptoBudé AS 'Total number of correspondents for whom the dataset contains only letters written by them to Budé but not vice versa',
       ROUND(B.NoCorrOnlyEpptoBudé * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written by them to Budé but not vice versa of the total number of correspondents',
       C.NoCorrReciproc AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Budé',
       ROUND(C.NoCorrReciproc * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains a reciprocal correspondence with Budé of the total number of correspondents'
FROM
  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEppFromBudé
   FROM bude_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM bude_cdb_v1.letters
        WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM bude_cdb_v1.letters
        WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoBudé
   FROM bude_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM bude_cdb_v1.letters
        WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM bude_cdb_v1.letters
        WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM bude_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM bude_cdb_v1.letters
        WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM bude_cdb_v1.letters
        WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM bude_cdb_v1.correspondents
   WHERE correspondents_id NOT IN ('c0b89c75-45b8-4b04-bfd7-25bfe9ed040b',
                                   'be1dcbc4-3987-472a-b4a0-c3305ead139f')) AS D
