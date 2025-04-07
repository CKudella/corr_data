SELECT L.letters_id AS 'Id',
       L.letter_no_in_edition,
       L.sender_id,
       L.sender_inferred,
       L.sender_uncertain,
       L.recipient_id,
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
       L.source_loc_id AS 'Source',
       L.source_loc_inferred,
       L.source_loc_uncertain,
       L.target_loc_id AS 'Target',
       L.target_loc_inferred,
       L.target_loc_uncertain,
       L.letter_language,
       L.letter_type_genus,
       L.letter_type_x_to_x
FROM
  (SELECT *
   FROM era_cdb_v3.letters
   UNION ALL
     (SELECT *
      FROM bude_cdb_v1.letters
      WHERE letters_id NOT LIKE '%_cwe_%'
        OR (letters_id LIKE 'gbudé_%'
            OR letters_id LIKE 'era_cwealien%'))) AS L
