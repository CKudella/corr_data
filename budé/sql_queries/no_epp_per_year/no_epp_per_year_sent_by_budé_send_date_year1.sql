SELECT DISTINCT letters.send_date_year1,
                COUNT(*) AS 'Total number of letters sent by Budé this year'
FROM bude_cdb_v1.letters
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND letters_id NOT LIKE '%ck2'
GROUP BY letters.send_date_year1
ORDER BY letters.send_date_year1 ASC
