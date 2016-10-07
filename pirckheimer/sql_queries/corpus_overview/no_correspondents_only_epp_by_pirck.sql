SELECT COUNT(*) AS 'Number of Correspondents that only received letters from Pirckheimer' FROM correspondents WHERE correspondents.correspondents_id NOT IN (SELECT DISTINCT sender_id FROM letters)
