SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Budé sent to this modern state this year to mutual correspondents of his and Erasmus (excl. Erasmus)',
                send_date_year1
FROM budé_cdb_v1.letters,
     budé_cdb_v1.locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND sender_id = 'budé_guillaume_viaf_105878228'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228'))
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
