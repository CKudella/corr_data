SELECT locations.locations_name_modern AS 'Location Name',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location from Pirckheimer'
FROM letters
JOIN locations ON locations.locations_id = letters.target_loc_id
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND sender_id = 'pirckheimer_willibald_viaf_27173507'
  AND recipient_id != 'erasmus_desiderius_viaf_95982394'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
