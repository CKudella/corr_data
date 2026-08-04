SELECT DISTINCT YEAR(send_date_computable1) AS 'Year',
                COUNT(*) AS 'Total number of letters sent by Budé this year'
FROM bude_cdb.letters
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND letters_id NOT LIKE '%ck2'
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1) ASC
