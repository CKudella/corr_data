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
        WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
          AND sender_id != 'unnamed_person_viaf_not_applicable')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoPirck
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
          AND recipient_id != 'unnamed_person_viaf_not_applicable') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM wpirck_cdb_v1.correspondents
   WHERE correspondents_id NOT IN ('pirckheimer_willibald_viaf_27173507',
                                   'unnamed_person_viaf_not_applicable')) AS D
