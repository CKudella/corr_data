SELECT locations_id
FROM era_cdb_v3.locations
WHERE locations_id NOT IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb_v3.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT target_loc_id
     FROM era_cdb_v3.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT pob_loc_id
     FROM era_cdb_v3.correspondents)
  AND locations_id NOT IN
    (SELECT DISTINCT pod_loc_id
     FROM era_cdb_v3.correspondents)
GROUP BY locations_id
