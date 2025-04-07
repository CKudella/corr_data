SELECT COUNT(CASE
                 WHEN l.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080' THEN 1
             END) AS 'Number of letters written by Pirckheimer',
       ROUND(COUNT(CASE
                       WHEN l.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written by Pirckheimer of the total number of letters in the dataset',
       COUNT(CASE
                 WHEN l.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080' THEN 1
             END) AS 'Number of letters written to Pirckheimer',
       ROUND(COUNT(CASE
                       WHEN l.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080' THEN 1
                   END) * 100.0 / COUNT(*), 1) AS 'Percentage of the number of letters written to Pirckheimer of the total number of letters in the dataset'
FROM wpirck_cdb.letters AS l
WHERE l.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
