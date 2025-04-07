SELECT L.letters_id AS 'Id',
       L.letter_no_in_edition,
       L.sender_id AS 'Source',
       L.sender_inferred,
       L.sender_uncertain,
       L.recipient_id AS 'Target',
       L.recipient_inferred,
       L.recipient_uncertain,
       L.label AS 'Label',
       L.send_date_year1,
       L.send_date_computable1,
       L.send_date_has_range,
       L.send_date_year2,
       L.send_date_computable2,
       L.send_date_inferred,
       L.send_date_approx,
       L.send_date_uncertain,
       L.source_loc_id,
       L.source_loc_inferred,
       L.source_loc_uncertain,
       L.target_loc_id,
       L.target_loc_inferred,
       L.target_loc_uncertain,
       L.letter_language,
       L.letter_type_genus,
       L.letter_type_x_to_x
FROM
  (SELECT *
   FROM era_cdb.letters
   UNION ALL
     (SELECT *
      FROM bude_cdb.letters AS BL
      WHERE BL.letters_id NOT LIKE '%_cwe_%'
        OR (BL.letters_id LIKE 'gbudé_%'
            OR BL.letters_id LIKE 'era_cwealien%'))) AS L
WHERE L.sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM bude_cdb.correspondents AS B,
               era_cdb.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id
            AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM bude_cdb.correspondents AS B,
               era_cdb.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id
            AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
