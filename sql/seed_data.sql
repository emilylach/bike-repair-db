-- Sample data: July 2025 - June 2026. All names and contact details are fictional.
USE BikeShop;


-- 9 customers
INSERT INTO customers (customer_id, first_name, last_name, email, phone, town)
VALUES
    (1, 'Maya',   'Torres',    'maya.torres@example.com',   '970-555-0101', 'Glenwood Springs'),
    (2, 'Ben',    'Okafor',    'ben.okafor@example.com',    '970-555-0102', 'Carbondale'),
    (3, 'Jake',   'Morrison',  'jake.m@example.com',        '970-555-0103', 'New Castle'),
    (4, 'Hannah', 'Lindqvist', 'hannah.l@example.com',      '970-555-0104', 'Glenwood Springs'),
    (5, 'Luis',   'Ramirez',   NULL,                        '970-555-0105', 'Rifle'),
    (6, 'Priya',  'Natarajan', 'priya.n@example.com',       NULL,           'Carbondale'),
    (7, 'Grace',  'Kim',       'grace.kim@example.com',     '970-555-0107', 'Glenwood Springs'),
    (8, 'Sam',    'Whitaker',  NULL,                        NULL,           'Rifle'),
    (9, 'Jake',   'Morrison',  'jmorrison.work@example.com','970-555-0103', 'New Castle');


-- 12 bikes
INSERT INTO bikes (bike_id, customer_id, make, model, bike_type, model_year)
VALUES
    (101, 1, 'Santa Cruz',     'Hightower',     'MOUNTAIN', 2022),
    (102, 1, 'Specialized',    'Diverge',       'GRAVEL',   2021),
    (103, 2, 'Trek',           'Fuel EX',       'MOUNTAIN', 2020),
    (104, 3, 'Yeti',           'SB140',         'MOUNTAIN', 2023),
    (105, 4, 'Cannondale',     'Synapse',       'ROAD',     2019),
    (106, 4, 'Specialized',    'Turbo Levo',    'E-BIKE',   2024),
    (107, 5, 'Giant',          'Trance',        'MOUNTAIN', 2018),
    (108, 6, 'Salsa',          'Cutthroat',     'GRAVEL',   2022),
    (109, 7, 'Trek',           'Domane',        'ROAD',     2023),
    (110, 8, 'Rocky Mountain', 'Instinct',      'MOUNTAIN', 2021),
    (111, 9, 'Pivot',          'Switchblade',   'MOUNTAIN', 2024),
    (112, 7, 'Orbea',          'Rise',          'E-BIKE',   2025);


-- 24 jobs
-- Labor rate: $90/hr through 2025, $95/hr from Jan 1, 2026.
INSERT INTO jobs (job_id, bike_id, job_date, service_type, labor_hours, labor_rate, status, notes)
VALUES
    (5001, 101, '2025-07-08', 'SUSPENSION',    2.00, 90.00, 'COMPLETED', 'Fork lower service'),
    (5002, 103, '2025-07-15', 'TUNE_UP',       1.50, 90.00, 'COMPLETED', 'Full tune up'),
    (5003, 105, '2025-07-22', 'FLAT_REPAIR',   0.50, 90.00, 'COMPLETED', 'Rear flat'),
    (5004, 107, '2025-08-05', 'BRAKE_SERVICE', 1.00, 90.00, 'COMPLETED', 'Pads and bleed'),
    (5005, 104, '2025-08-12', 'DRIVETRAIN',    1.50, 90.00, 'COMPLETED', 'Worn chain and cassette'),
    (5006, 108, '2025-08-19', 'TUNE_UP',       1.50, 90.00, 'COMPLETED', 'Pre-trip tune up'),
    (5007, 110, '2025-09-03', 'FLAT_REPAIR',   0.50, 90.00, 'COMPLETED', 'Tubeless top-up'),
    (5008, 102, '2025-09-10', 'TUNE_UP',       1.50, 90.00, 'COMPLETED', 'Tune up and new bar tape'),
    (5009, 109, '2025-09-24', 'BRAKE_SERVICE', 0.00, 90.00, 'CANCELLED', 'Customer cancelled'),
    (5010, 106, '2025-10-07', 'DRIVETRAIN',    1.00, 90.00, 'COMPLETED', 'E-bike chain'),
    (5011, 103, '2025-10-21', 'SUSPENSION',    2.50, 90.00, 'COMPLETED', 'Fork and shock service'),
    (5012, 111, '2025-11-04', 'TUNE_UP',       1.50, 90.00, 'COMPLETED', 'End of season tune up'),
    (5013, 106, '2026-01-13', 'BRAKE_SERVICE', 1.00, 95.00, 'COMPLETED', 'Pads'),
    (5014, 101, '2026-03-10', 'TUNE_UP',       1.50, 95.00, 'COMPLETED', 'Spring tune up'),
    (5015, 104, '2026-03-24', 'SUSPENSION',    2.00, 95.00, 'COMPLETED', 'Fork lower service'),
    (5016, 109, '2026-04-07', 'TUNE_UP',       1.50, 95.00, 'COMPLETED', 'Tune up and new bar tape'),
    (5017, 105, '2026-04-14', 'WHEEL_TRUE',    0.50, 95.00, 'COMPLETED', 'Broken spokes'),
    (5018, 103, '2026-04-21', 'BRAKE_SERVICE', 1.00, 95.00, 'COMPLETED', 'Pads'),
    (5019, 108, '2026-05-05', 'FLAT_REPAIR',   0.00, 95.00, 'COMPLETED', 'Flat fixed'),
    (5020, 102, '2026-05-12', 'DRIVETRAIN',    1.50, 95.00, 'COMPLETED', 'Chain and chainring'),
    (5021, 106, '2026-05-19', 'TUNE_UP',       1.50, 95.00, 'COMPLETED', 'Tune up'),
    (5022, 111, '2026-06-02', 'SUSPENSION',    2.00, 95.00, 'COMPLETED', 'Shock service'),
    (5023, 101, '2026-06-09', 'BRAKE_SERVICE', 1.00, 95.00, 'COMPLETED', 'New rotors'),
    (5024, 109, '2026-06-16', 'FLAT_REPAIR',   0.50, 95.00, 'COMPLETED', 'Front flat');


-- 27 part lines
INSERT INTO parts (job_part_id, job_id, part_name, quantity, unit_cost, unit_price)
VALUES
    ( 1, 5001, 'Fork seal kit',      1, 35.00,  60.00),
    ( 2, 5001, 'Suspension oil',     1, 12.00,  20.00),
    ( 3, 5002, 'Shift cable',        1,  6.00,  12.00),
    ( 4, 5003, 'Inner tube',         1,  6.00,  12.00),
    ( 5, 5004, 'Brake pads',         2, 18.00,  32.00),
    ( 6, 5004, 'Brake fluid',        1,  8.00,  15.00),
    ( 7, 5005, 'Chain',              1, 35.00,  55.00),
    ( 8, 5005, 'Cassette',           1, 70.00, 110.00),
    ( 9, 5006, 'Shift cable',        1,  6.00,  12.00),
    (10, 5007, 'Tubeless sealant',   1,  8.00,  15.00),
    (11, 5008, 'Bar tape',           1, 15.00,  28.00),
    (12, 5010, 'E-bike chain',       1, 45.00,  70.00),
    (13, 5011, 'Fork seal kit',      1, 35.00,  60.00),
    (14, 5011, 'Shock service kit',  1, 40.00,  70.00),
    (15, 5012, 'Shift cable',        1,  6.00,  12.00),
    (16, 5013, 'Brake pads',         2, 18.00,  32.00),
    (17, 5014, 'Shift cable',        1,  6.00,  12.00),
    (18, 5015, 'Fork seal kit',      1, 35.00,  60.00),
    (19, 5016, 'Bar tape',           1, 15.00,  28.00),
    (20, 5017, 'Spoke',              3,  2.00,   4.00),
    (21, 5018, 'Brake pads',         2, 18.00,  32.00),
    (22, 5020, 'Chain',              1, 35.00,  55.00),
    (23, 5020, 'Chainring',          1, 50.00,  45.00),
    (24, 5021, 'Shift cable',        1,  6.00,  12.00),
    (25, 5022, 'Shock service kit',  1, 40.00,  70.00),
    (26, 5023, 'Brake rotor',        2, 30.00,  45.00),
    (27, 5024, 'Inner tube',         1,  6.00,  12.00);


-- Row counts
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'bikes', COUNT(*) FROM bikes
UNION ALL
SELECT 'jobs', COUNT(*) FROM jobs
UNION ALL
SELECT 'job_parts', COUNT(*) FROM parts;
