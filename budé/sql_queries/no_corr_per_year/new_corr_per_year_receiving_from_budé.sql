SELECT * FROM
(SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1484'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1484')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1487'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1487')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1488'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1488')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1489'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1489')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1493'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1493')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1494'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1494')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1495'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1495')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1496'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1496')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1497'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1497')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1498'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1498')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1499'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1499')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1500'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1500')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1501'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1501')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1502'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1502')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1503'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1503')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1504'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1504')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1505'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1505')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1506'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1506')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1507'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1507')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1508'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1508')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1509'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1509')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1511'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1511')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1512'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1512')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1513'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1513')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1514'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1514')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1515'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1515')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1516'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1516')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1517'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1517')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1518'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1518')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1519'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1519')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1520'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1520')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1521'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1521')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1522'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1522')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1523'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1523')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1524'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1524')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1525'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1525')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1526'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1526')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1527'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1527')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1528'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1528')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1529'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1529')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1530'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1530')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1531'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1531')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1532'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1532')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1533'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1533')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1534'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1534')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1535'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1535')
UNION ALL
SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS  NewCorrReceivingFromBudé
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND send_date_year1 = '1536'
  AND recipient_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND send_date_year1 < '1536')
       UNION ALL
       SELECT send_date_year1 AS YEAR,
              COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
       FROM letters
       WHERE recipient_id = 'budé_guillaume_viaf_105878228'
         AND send_date_year1 = '1537'
         AND sender_id NOT IN
           (SELECT DISTINCT sender_id
            FROM letters
            WHERE recipient_id = 'budé_guillaume_viaf_105878228'
              AND send_date_year1 < '1537')
       UNION ALL
       SELECT send_date_year1 AS YEAR,
              COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
       FROM letters
       WHERE recipient_id = 'budé_guillaume_viaf_105878228'
         AND send_date_year1 = '1538'
         AND sender_id NOT IN
           (SELECT DISTINCT sender_id
            FROM letters
            WHERE recipient_id = 'budé_guillaume_viaf_105878228'
              AND send_date_year1 < '1538')
       UNION ALL
       SELECT send_date_year1 AS YEAR,
              COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
       FROM letters
       WHERE recipient_id = 'budé_guillaume_viaf_105878228'
         AND send_date_year1 = '1539'
         AND sender_id NOT IN
           (SELECT DISTINCT sender_id
            FROM letters
            WHERE recipient_id = 'budé_guillaume_viaf_105878228'
              AND send_date_year1 < '1539')
       UNION ALL
       SELECT send_date_year1 AS YEAR,
              COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
       FROM letters
       WHERE recipient_id = 'budé_guillaume_viaf_105878228'
         AND send_date_year1 = '1540'
         AND sender_id NOT IN
           (SELECT DISTINCT sender_id
            FROM letters
            WHERE recipient_id = 'budé_guillaume_viaf_105878228'
              AND send_date_year1 < '1540')) AS A
WHERE A.YEAR IS NOT NULL
