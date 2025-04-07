SELECT *
FROM era_cdb.letters
WHERE letters.letters_id NOT LIKE '%cwe%'
  AND letters.letters_id NOT LIKE '%allen%'
  AND letters.letters_id NOT LIKE '%cde%'
