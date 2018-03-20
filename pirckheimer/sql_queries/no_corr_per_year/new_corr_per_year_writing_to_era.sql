SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1484'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1484')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1487'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1487')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1488'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1488')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1489'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1489')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1493'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1493')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1494'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1494')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1495'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1495')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1496'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1496')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1497'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1497')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1498'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1498')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1499'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1499')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1500'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1500')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1501'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1501')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1502'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1502')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1503'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1503')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1504'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1504')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1505'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1505')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1506'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1506')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1507'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1507')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1508'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1508')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1509'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1509')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1511'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1511')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1512'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1512')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1513'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1513')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1514'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1514')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1515'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1515')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1516'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1516')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1517'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1517')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1518'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1518')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1519'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1519')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1520'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1520')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1521'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1521')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1522'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1522')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1523'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1523')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1524'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1524')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1525'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1525')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1526'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1526')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1527'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1527')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1528'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1528')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1529'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1529')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1530'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1530')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1531'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1531')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1532'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1532')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1533'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1533')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1534'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1534')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1535'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1535')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND send_date_year1 = '1536'
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters
     WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
       AND send_date_year1 < '1536')
