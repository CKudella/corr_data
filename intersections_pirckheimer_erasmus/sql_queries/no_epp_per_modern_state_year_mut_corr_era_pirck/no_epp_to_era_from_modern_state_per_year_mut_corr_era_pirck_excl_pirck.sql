SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state to Erasmus this year from mutual correspondents of his and Pirckheimer (excl. Pirckheimer)',
                send_date_year1
FROM era_cdb_v3.letters,
     era_cdb_v3.locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND recipient_id = 'erasmus_desiderius_viaf_95982394'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS P,
          era_cdb_v3.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'pirckheimer_willibald_viaf_27173507'))
GROUP BY locations_modern_state,
         send_date_year1
ORDER BY send_date_year1 ASC
