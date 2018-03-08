SELECT A.NoCorrOnlyEppFromEra AS 'Total number of correspondents for whom the dataset contains only letters written to them from Erasmus but not vice versa',
       ROUND(A.NoCorrOnlyEppFromEra * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written to them from Erasmus but not vice versa of the total number of correspondents',
       B.NoCorrOnlyEpptoEra AS 'Total number of correspondents for whom the dataset contains only letters written from them to Erasmus but not vice versa',
       ROUND(B.NoCorrOnlyEpptoEra * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written from them to Erasmus but not vice versa of the total number of correspondents',
       C.NoCorrReciproc AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus',
       ROUND(C.NoCorrReciproc * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus of the total number of correspondents'
FROM
  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEppFromEra
   FROM era_cdb_v3.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
          AND sender_id != 'unnamed_person_viaf_not_applicable')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoEra
   FROM era_cdb_v3.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
          AND recipient_id != 'unnamed_person_viaf_not_applicable') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM era_cdb_v3.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM era_cdb_v3.correspondents
   WHERE correspondents_id NOT IN ('erasmus_desiderius_viaf_95982394',
                                   'unnamed_person_viaf_not_applicable')) AS D
