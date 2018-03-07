SELECT *
FROM era_cdb_v3.letters
WHERE letters.letters_id NOT LIKE '%cwe%'
  AND letters.letters_id NOT LIKE '%allen%'
  AND letters.letters_id NOT LIKE '%cde%'
