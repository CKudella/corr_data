SELECT locations_id
FROM wpirck_cdb.locations
WHERE locations_id NOT IN
    (SELECT DISTINCT source_loc_id
     FROM wpirck_cdb.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT target_loc_id
     FROM wpirck_cdb.letters)
  AND locations_id NOT IN
    (SELECT DISTINCT pob_loc_id
     FROM wpirck_cdb.correspondents)
  AND locations_id NOT IN
    (SELECT DISTINCT pod_loc_id
     FROM wpirck_cdb.correspondents)
GROUP BY locations_id
