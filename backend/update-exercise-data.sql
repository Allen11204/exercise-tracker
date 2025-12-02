-- Update exercise data for allen (user_id=24), john_doe (user_id=4), and david_wilson (user_id=8)
-- Adding recent 7 days of data (Nov 26 - Dec 2, 2025)

-- Delete existing recent data for these users to avoid duplicates
DELETE FROM exercises WHERE user_id IN (24, 4, 8) AND occurred_at >= '2025-11-26 00:00:00';

-- Allen (user_id=24) - Active runner and gym enthusiast from New York
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
-- December 2, 2025
(24, 'RUN', 45, 'Central Park', '2025-12-02 07:00:00', 'America/New_York'),
(24, 'GYM', 60, 'Equinox Gym', '2025-12-02 18:30:00', 'America/New_York'),
-- December 1, 2025
(24, 'WALK', 30, 'Riverside Park', '2025-12-01 08:00:00', 'America/New_York'),
(24, 'GYM', 55, 'Equinox Gym', '2025-12-01 19:00:00', 'America/New_York'),
-- November 30, 2025
(24, 'RUN', 50, 'Brooklyn Bridge', '2025-11-30 07:15:00', 'America/New_York'),
(24, 'SWIM', 40, 'Chelsea Piers', '2025-11-30 17:00:00', 'America/New_York'),
-- November 29, 2025
(24, 'CYCLE', 60, 'Hudson River Greenway', '2025-11-29 08:00:00', 'America/New_York'),
(24, 'GYM', 50, 'Equinox Gym', '2025-11-29 18:00:00', 'America/New_York'),
-- November 28, 2025
(24, 'RUN', 40, 'Central Park', '2025-11-28 07:00:00', 'America/New_York'),
(24, 'WALK', 35, 'High Line', '2025-11-28 19:00:00', 'America/New_York'),
-- November 27, 2025
(24, 'GYM', 65, 'Equinox Gym', '2025-11-27 07:30:00', 'America/New_York'),
(24, 'SWIM', 45, 'Chelsea Piers', '2025-11-27 18:00:00', 'America/New_York'),
-- November 26, 2025
(24, 'RUN', 50, 'Central Park', '2025-11-26 07:00:00', 'America/New_York'),
(24, 'CYCLE', 55, 'Hudson River Greenway', '2025-11-26 17:30:00', 'America/New_York');

-- John Doe (user_id=4) - Moderate exerciser from Chicago
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
-- December 2, 2025
(4, 'RUN', 40, 'Lakefront Trail', '2025-12-02 07:30:00', 'America/Chicago'),
(4, 'WALK', 30, 'Millennium Park', '2025-12-02 17:00:00', 'America/Chicago'),
-- December 1, 2025
(4, 'GYM', 50, 'LA Fitness', '2025-12-01 08:00:00', 'America/Chicago'),
(4, 'WALK', 25, 'Navy Pier', '2025-12-01 18:00:00', 'America/Chicago'),
-- November 30, 2025
(4, 'RUN', 35, 'Lakefront Trail', '2025-11-30 07:00:00', 'America/Chicago'),
(4, 'GYM', 45, 'LA Fitness', '2025-11-30 18:30:00', 'America/Chicago'),
-- November 29, 2025
(4, 'WALK', 30, 'Grant Park', '2025-11-29 08:00:00', 'America/Chicago'),
(4, 'GYM', 40, 'LA Fitness', '2025-11-29 19:00:00', 'America/Chicago'),
-- November 28, 2025
(4, 'RUN', 45, 'Lakefront Trail', '2025-11-28 07:30:00', 'America/Chicago'),
(4, 'WALK', 35, 'Lincoln Park', '2025-11-28 17:30:00', 'America/Chicago'),
-- November 27, 2025
(4, 'GYM', 50, 'LA Fitness', '2025-11-27 08:00:00', 'America/Chicago'),
(4, 'WALK', 30, 'Millennium Park', '2025-11-27 18:00:00', 'America/Chicago'),
-- November 26, 2025
(4, 'RUN', 40, 'Lakefront Trail', '2025-11-26 07:00:00', 'America/Chicago'),
(4, 'GYM', 45, 'LA Fitness', '2025-11-26 18:30:00', 'America/Chicago');

-- David Wilson (user_id=8) - Swimming enthusiast from Paris
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
-- December 2, 2025
(8, 'SWIM', 45, 'Piscine Pontoise', '2025-12-02 07:30:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Jardin du Luxembourg', '2025-12-02 17:00:00', 'Europe/Paris'),
-- December 1, 2025
(8, 'SWIM', 50, 'Piscine Pontoise', '2025-12-01 08:00:00', 'Europe/Paris'),
(8, 'WALK', 25, 'Seine Riverbank', '2025-12-01 18:00:00', 'Europe/Paris'),
-- November 30, 2025
(8, 'SWIM', 40, 'Piscine Pontoise', '2025-11-30 07:00:00', 'Europe/Paris'),
(8, 'WALK', 35, 'Champs-Élysées', '2025-11-30 17:30:00', 'Europe/Paris'),
-- November 29, 2025
(8, 'SWIM', 45, 'Piscine Pontoise', '2025-11-29 07:30:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Tuileries Garden', '2025-11-29 18:00:00', 'Europe/Paris'),
-- November 28, 2025
(8, 'SWIM', 50, 'Piscine Pontoise', '2025-11-28 08:00:00', 'Europe/Paris'),
(8, 'WALK', 25, 'Montmartre', '2025-11-28 17:00:00', 'Europe/Paris'),
-- November 27, 2025
(8, 'SWIM', 40, 'Piscine Pontoise', '2025-11-27 07:00:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Jardin du Luxembourg', '2025-11-27 18:00:00', 'Europe/Paris'),
-- November 26, 2025
(8, 'SWIM', 45, 'Piscine Pontoise', '2025-11-26 07:30:00', 'Europe/Paris'),
(8, 'WALK', 35, 'Seine Riverbank', '2025-11-26 17:30:00', 'Europe/Paris');

-- Adding October data (October 1-7, 2025) for all three users
-- Allen (user_id=24) - October 1-7
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
(24, 'RUN', 45, 'Central Park', '2025-10-01 07:00:00', 'America/New_York'),
(24, 'GYM', 55, 'Equinox Gym', '2025-10-01 18:00:00', 'America/New_York'),
(24, 'WALK', 30, 'Riverside Park', '2025-10-02 08:00:00', 'America/New_York'),
(24, 'SWIM', 40, 'Chelsea Piers', '2025-10-02 17:30:00', 'America/New_York'),
(24, 'RUN', 50, 'Brooklyn Bridge', '2025-10-03 07:15:00', 'America/New_York'),
(24, 'GYM', 60, 'Equinox Gym', '2025-10-03 18:30:00', 'America/New_York'),
(24, 'CYCLE', 55, 'Hudson River Greenway', '2025-10-04 08:00:00', 'America/New_York'),
(24, 'WALK', 35, 'High Line', '2025-10-04 19:00:00', 'America/New_York'),
(24, 'RUN', 40, 'Central Park', '2025-10-05 07:00:00', 'America/New_York'),
(24, 'GYM', 50, 'Equinox Gym', '2025-10-05 18:00:00', 'America/New_York'),
(24, 'SWIM', 45, 'Chelsea Piers', '2025-10-06 08:00:00', 'America/New_York'),
(24, 'CYCLE', 60, 'Hudson River Greenway', '2025-10-06 17:00:00', 'America/New_York'),
(24, 'RUN', 50, 'Central Park', '2025-10-07 07:30:00', 'America/New_York'),
(24, 'GYM', 55, 'Equinox Gym', '2025-10-07 18:30:00', 'America/New_York');

-- John Doe (user_id=4) - October 1-7
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
(4, 'RUN', 35, 'Lakefront Trail', '2025-10-01 07:30:00', 'America/Chicago'),
(4, 'WALK', 30, 'Millennium Park', '2025-10-01 17:00:00', 'America/Chicago'),
(4, 'GYM', 45, 'LA Fitness', '2025-10-02 08:00:00', 'America/Chicago'),
(4, 'WALK', 25, 'Navy Pier', '2025-10-02 18:00:00', 'America/Chicago'),
(4, 'RUN', 40, 'Lakefront Trail', '2025-10-03 07:00:00', 'America/Chicago'),
(4, 'GYM', 50, 'LA Fitness', '2025-10-03 18:30:00', 'America/Chicago'),
(4, 'WALK', 30, 'Grant Park', '2025-10-04 08:00:00', 'America/Chicago'),
(4, 'GYM', 40, 'LA Fitness', '2025-10-04 19:00:00', 'America/Chicago'),
(4, 'RUN', 45, 'Lakefront Trail', '2025-10-05 07:30:00', 'America/Chicago'),
(4, 'WALK', 35, 'Lincoln Park', '2025-10-05 17:30:00', 'America/Chicago'),
(4, 'GYM', 50, 'LA Fitness', '2025-10-06 08:00:00', 'America/Chicago'),
(4, 'WALK', 30, 'Millennium Park', '2025-10-06 18:00:00', 'America/Chicago'),
(4, 'RUN', 40, 'Lakefront Trail', '2025-10-07 07:00:00', 'America/Chicago'),
(4, 'GYM', 45, 'LA Fitness', '2025-10-07 18:30:00', 'America/Chicago');

-- David Wilson (user_id=8) - October 1-7
INSERT INTO exercises (user_id, type, duration_minutes, location, occurred_at, timezone) VALUES
(8, 'SWIM', 40, 'Piscine Pontoise', '2025-10-01 07:30:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Jardin du Luxembourg', '2025-10-01 17:00:00', 'Europe/Paris'),
(8, 'SWIM', 45, 'Piscine Pontoise', '2025-10-02 08:00:00', 'Europe/Paris'),
(8, 'WALK', 25, 'Seine Riverbank', '2025-10-02 18:00:00', 'Europe/Paris'),
(8, 'SWIM', 50, 'Piscine Pontoise', '2025-10-03 07:00:00', 'Europe/Paris'),
(8, 'WALK', 35, 'Champs-Élysées', '2025-10-03 17:30:00', 'Europe/Paris'),
(8, 'SWIM', 40, 'Piscine Pontoise', '2025-10-04 07:30:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Tuileries Garden', '2025-10-04 18:00:00', 'Europe/Paris'),
(8, 'SWIM', 45, 'Piscine Pontoise', '2025-10-05 08:00:00', 'Europe/Paris'),
(8, 'WALK', 25, 'Montmartre', '2025-10-05 17:00:00', 'Europe/Paris'),
(8, 'SWIM', 50, 'Piscine Pontoise', '2025-10-06 07:00:00', 'Europe/Paris'),
(8, 'WALK', 30, 'Jardin du Luxembourg', '2025-10-06 18:00:00', 'Europe/Paris'),
(8, 'SWIM', 40, 'Piscine Pontoise', '2025-10-07 07:30:00', 'Europe/Paris'),
(8, 'WALK', 35, 'Seine Riverbank', '2025-10-07 17:30:00', 'Europe/Paris');

-- Summary:
-- Allen (user_id=24): 14 exercises in Oct (Oct 1-7) + 14 exercises in recent 7 days (Nov 26-Dec 2) = 28 new records
-- John Doe (user_id=4): 14 exercises in Oct (Oct 1-7) + 14 exercises in recent 7 days (Nov 26-Dec 2) = 28 new records
-- David Wilson (user_id=8): 14 exercises in Oct (Oct 1-7) + 14 exercises in recent 7 days (Nov 26-Dec 2) = 28 new records
-- Total: 84 new exercise records
