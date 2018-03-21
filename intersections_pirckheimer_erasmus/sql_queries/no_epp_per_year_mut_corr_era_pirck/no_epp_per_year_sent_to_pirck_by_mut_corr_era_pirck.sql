SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent to Pirckheimer this year to mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM wpirck_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS P,
          era_cdb_v3.correspondents AS E
     WHERE correspondents_id = E.correspondents_id
       AND correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507'))
GROUP BY send_date_year1
