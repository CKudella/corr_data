SELECT *
FROM letters
WHERE send_date_as_marked NOT LIKE '%Jan%'
  AND send_date_as_marked NOT LIKE '%Feb%'
  AND send_date_as_marked NOT LIKE '%Mar%'
  AND send_date_as_marked NOT LIKE '%Apr%'
  AND send_date_as_marked NOT LIKE '%May%'
  AND send_date_as_marked NOT LIKE '%Jun%'
  AND send_date_as_marked NOT LIKE '%Jul%'
  AND send_date_as_marked NOT LIKE '%Aug%'
  AND send_date_as_marked NOT LIKE '%Sep%'
  AND send_date_as_marked NOT LIKE '%Oct%'
  AND send_date_as_marked NOT LIKE '%Nov%'
  AND send_date_as_marked NOT LIKE '%Dec%'
