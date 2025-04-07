SELECT COUNT(CASE
                 WHEN l.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b' THEN 1
             END) AS 'Number of letters written by Budé',
       ROUND(COUNT(CASE
                       WHEN l.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written by Budé of the total number of letters in the dataset',
       COUNT(CASE
                 WHEN l.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b' THEN 1
             END) AS 'Number of letters written to Budé',
       ROUND(COUNT(CASE
                       WHEN l.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written to Budé of the total number of letters in the dataset'
FROM bude_cdb.letters AS l
WHERE l.letters_id NOT LIKE '%ck2'
