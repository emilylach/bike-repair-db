--  Queries info from BikeShop databases and applies analytics
USE BikeShop;


-- =========================================================
-- Customers and bikes information
-- =========================================================

-- Number of bikes by type
SELECT bike_type, COUNT(*) AS bikes
FROM bikes
GROUP BY bike_type
ORDER BY bikes;
GO

-- Last service date per customer
SELECT c.customer_id, c.first_name, c.last_name,
    COUNT(*) AS completed_jobs,
    MAX(j.job_date) AS last_visit
FROM customers AS c
JOIN bikes AS b ON c.customer_id = b.customer_id
JOIN jobs  AS j ON b.bike_id = j.bike_id
WHERE j.status = 'COMPLETED'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY last_visit;
GO


-- Identify customers that haven't brought a bike in since 2026-01-01.
SELECT c.customer_id, c.first_name, c.last_name, c.phone, c.email,
    MAX(j.job_date) AS last_visit
FROM customers AS c
JOIN bikes AS b ON c.customer_id = b.customer_id
JOIN jobs  AS j ON b.bike_id = j.bike_id
WHERE j.status = 'COMPLETED'
GROUP BY c.customer_id, c.first_name, c.last_name, c.phone, c.email
HAVING MAX(j.job_date) < '2026-01-01';
GO

-- Bikes on file that have never been serviced
SELECT b.bike_id, b.make, b.model, b.bike_type, b.customer_id
FROM bikes AS b
LEFT JOIN jobs AS j ON b.bike_id = j.bike_id
WHERE j.job_id IS NULL;
GO


-- =========================================================
-- Operations
-- =========================================================

-- Completed jobs by service type
SELECT service_type, COUNT(*) AS completed_jobs
FROM jobs
WHERE status = 'COMPLETED'
GROUP BY service_type
ORDER BY completed_jobs DESC;

-- Service type by bike type and number of jobs
SELECT b.bike_type, j.service_type, COUNT(*) AS jobs
FROM jobs AS j
JOIN bikes AS b ON j.bike_id = b.bike_id
WHERE j.status = 'COMPLETED'
GROUP BY b.bike_type, j.service_type
ORDER BY b.bike_type, jobs DESC;

-- Bikes serviced 3+ times
SELECT b.bike_id, b.make, b.model, COUNT(*) AS completed_jobs
FROM jobs AS j
JOIN bikes AS b ON j.bike_id = b.bike_id
WHERE j.status = 'COMPLETED'
GROUP BY b.bike_id, b.make, b.model
HAVING COUNT(*) >= 3;


-- =========================================================
-- Revenue
-- =========================================================

-- Revenue from labor by month
SELECT YEAR(job_date) AS job_year,
    MONTH(job_date) AS job_month,
    COUNT(*) AS jobs,
    SUM(labor_hours * labor_rate) AS labor_revenue
FROM jobs
WHERE status = 'COMPLETED'
GROUP BY YEAR(job_date), MONTH(job_date)
ORDER BY job_year, job_month;

-- Total bill per job (labor + parts).
-- Part totals are summed per job in CTE
WITH parts_per_job AS (
    SELECT job_id, SUM(quantity * unit_price) AS parts_total
    FROM parts
    GROUP BY job_id
)
SELECT j.job_id,
    j.job_date,
    j.service_type,
    j.labor_hours * j.labor_rate AS labor_total,
    COALESCE(p.parts_total, 0) AS parts_total,
    j.labor_hours * j.labor_rate + COALESCE(p.parts_total, 0) AS job_total
FROM jobs AS j
LEFT JOIN parts_per_job AS p ON j.job_id = p.job_id
WHERE j.status = 'COMPLETED'
ORDER BY job_total DESC;

-- Total revenue per customer
-- Part totals are summed per job in CTE
-- Jobs and bikes are joined on bike_id
-- resulting table is joined on customer_id
WITH parts_per_job AS (
    SELECT job_id, SUM(quantity * unit_price) AS parts_total
    FROM parts
    GROUP BY job_id
)
SELECT c.customer_id, c.first_name, c.last_name,
    COUNT(*) AS completed_jobs,
    SUM(j.labor_hours * j.labor_rate + COALESCE(p.parts_total, 0)) AS total_revenue
FROM jobs AS j
JOIN bikes AS b ON j.bike_id = b.bike_id
JOIN customers AS c ON b.customer_id = c.customer_id
LEFT JOIN parts_per_job AS p ON j.job_id = p.job_id
WHERE j.status = 'COMPLETED'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue;


-- =========================================================
-- Parts
-- =========================================================

-- Units sold, revenue and profit by part
SELECT part_name,
    SUM(quantity) AS units_sold,
    SUM(quantity * unit_price) AS parts_revenue,
    SUM(quantity * (unit_price - unit_cost)) AS parts_profit
FROM parts
GROUP BY part_name
ORDER BY parts_profit;
