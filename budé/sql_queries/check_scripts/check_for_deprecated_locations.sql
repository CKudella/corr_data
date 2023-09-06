SELECT locations_id
FROM budé_cdb_v1.locations
WHERE locations_id NOT IN
    (SELECT DISTINCT source_loc_id
     FROM budé_cdb_v1.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT target_loc_id
     FROM budé_cdb_v1.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT pob_loc_id
     FROM budé_cdb_v1.correspondents)
  AND locations_id NOT IN
    (SELECT DISTINCT pod_loc_id
     FROM budé_cdb_v1.correspondents)
GROUP BY locations_id
