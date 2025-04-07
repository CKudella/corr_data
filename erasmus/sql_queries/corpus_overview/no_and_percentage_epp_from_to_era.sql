SELECT COUNT(CASE
                 WHEN l.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf' THEN 1
             END) AS 'Number of letters written by Erasmus',
       ROUND(COUNT(CASE
                       WHEN l.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written by Erasmus of the total number of letters in the dataset',
       COUNT(CASE
                 WHEN l.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf' THEN 1
             END) AS 'Number of letters written to Erasmus',
       ROUND(COUNT(CASE
                       WHEN l.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written to Erasmus of the total number of letters in the dataset'
FROM era_cdb.letters AS l
WHERE l.letters_id NOT LIKE '%ck2'
