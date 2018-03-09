SELECT A.NoCorrOnlyEppFromBudé AS 'Total number of correspondents for whom the dataset contains only letters written to them from Budé but not vice versa',
       ROUND(A.NoCorrOnlyEppFromBudé * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written to them from Budé but not vice versa of the total number of correspondents',
       B.NoCorrOnlyEpptoBudé AS 'Total number of correspondents for whom the dataset contains only letters written from them to Budé but not vice versa',
       ROUND(B.NoCorrOnlyEpptoBudé * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains only letters written from them to Budé but not vice versa of the total number of correspondents',
       C.NoCorrReciproc AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Budé',
       ROUND(C.NoCorrReciproc * 100.0 / D.TotalNoCorr, 1) AS 'Percentage of the total number of correspondents for whom the dataset contains a reciprocal correspondence with Budé of the total number of correspondents'
FROM
  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEppFromBudé
   FROM budé_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'budé_guillaume_viaf_105878228'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'budé_guillaume_viaf_105878228'
          AND sender_id != 'unnamed_person_viaf_not_applicable')) AS A,

  (SELECT COUNT(correspondents_id) AS NoCorrOnlyEpptoBudé
   FROM budé_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'budé_guillaume_viaf_105878228'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id NOT IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'budé_guillaume_viaf_105878228'
          AND recipient_id != 'unnamed_person_viaf_not_applicable') ) AS B,

  (SELECT COUNT(correspondents_id) AS NoCorrReciproc
   FROM budé_cdb_v1.correspondents
   WHERE correspondents_id IN
       (SELECT DISTINCT sender_id
        FROM letters
        WHERE recipient_id = 'budé_guillaume_viaf_105878228'
          AND sender_id != 'unnamed_person_viaf_not_applicable')
     AND correspondents_id IN
       (SELECT DISTINCT recipient_id
        FROM letters
        WHERE sender_id = 'budé_guillaume_viaf_105878228'
          AND recipient_id != 'unnamed_person_viaf_not_applicable')) AS C,

  (SELECT COUNT(correspondents_id) AS TotalNoCorr
   FROM budé_cdb_v1.correspondents
   WHERE correspondents_id NOT IN ('budé_guillaume_viaf_105878228',
                                   'unnamed_person_viaf_not_applicable')) AS D
