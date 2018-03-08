SELECT COUNT(correspondents_id) AS 'Total number of correspondents for whom the dataset contains a reciprocal correspondence with Erasmus'
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
        AND recipient_id != 'unnamed_person_viaf_not_applicable')
