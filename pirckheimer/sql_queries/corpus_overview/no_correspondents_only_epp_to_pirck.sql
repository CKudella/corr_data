SELECT COUNT(*) AS 'Number of Correspondents that only wrote letters to Pirckheimer' FROM correspondents WHERE correspondents.correspondents_id NOT IN (SELECT DISTINCT recipient_id FROM letters)
