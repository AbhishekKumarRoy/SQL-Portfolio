-- Sourced from Spotify - Medium
-- https://datalemur.com/questions/spotify-streaming-history

WITH all_songs AS (
  SELECT 
    user_id,
    song_id,
    COUNT(*) AS song_plays
  FROM songs_weekly
  WHERE listen_time::DATE < '08/05/2022'
  GROUP BY user_id, song_id
  
  UNION ALL
  
  SELECT 
    user_id,
    song_id,
    song_plays AS song_plays
  FROM songs_history
)

SELECT 
  user_id,
  song_id,
  SUM(song_plays) AS song_plays
FROM all_songs
GROUP BY 
  user_id,
  song_id
ORDER BY song_plays DESC
