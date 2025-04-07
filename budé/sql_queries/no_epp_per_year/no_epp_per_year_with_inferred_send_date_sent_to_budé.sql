SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent to Budé this year'
FROM bude_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY send_date_year1
