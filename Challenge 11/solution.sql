CREATE TABLE users (
id INTEGER PRIMARY KEY,
username VARCHAR(50)
);

INSERT INTO users (id, username) VALUES
(1, 'john_doe'),
(2, 'jane_smith'),
(3, 'bob_wilson');

CREATE TABLE song_plays (
id INTEGER PRIMARY KEY,
played_at DATETIME,
user_id INTEGER,
song_id INTEGER
);

INSERT INTO song_plays (id, played_at, user_id, song_id) VALUES
(1, '2024-01-01 10:00:00', 1, 101),
(2, '2024-01-01 14:00:00', 1, 101),
(3, '2024-01-02 09:00:00', 1, 102),
(4, '2024-01-03 16:00:00', 1, 103),
(5, '2024-01-04 11:00:00', 1, 104),
(6, '2024-01-01 09:00:00', 2, 201),
(7, '2024-01-01 15:00:00', 2, 202),
(8, '2024-01-02 10:00:00', 2, 203),
(9, '2024-01-02 14:00:00', 2, 203),
(10, '2024-01-01 12:00:00', 3, 301),
(11, '2024-01-02 13:00:00', 3, 302);

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema

WITH unique_plays as (
    select user_id, song_id, MIN(played_at) as played_at
    from song_plays
    group by user_id, song_id
)
  
, ranked_plays as (
    select user_id, played_at, song_id,
           ROW_NUMBER() OVER (PARTITION by user_id order by played_at) AS rank
    from unique_plays
)

, third_song_played as (
select user_id, song_id, played_at
from ranked_plays
where rank = 3
)

select u.username, sp.song_id, sp.played_at as created_at
from third_song_played sp
inner join users u on u.id = sp.user_id
order by created_at

