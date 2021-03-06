SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent by Budé this year to mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
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
GROUP BY send_date_year1
