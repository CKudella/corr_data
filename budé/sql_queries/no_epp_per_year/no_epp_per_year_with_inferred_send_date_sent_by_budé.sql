SELECT DISTINCT YEAR(send_date_computable1) AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent by Budé this year'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY YEAR(send_date_computable1)
