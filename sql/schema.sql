-- Schema: customers -> bikes -> jobs -> job_parts
USE BikeShop;

DROP TABLE IF EXISTS job_parts;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS bikes;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id  INT          PRIMARY KEY,
    first_name   VARCHAR(50)  NOT NULL,
    last_name    VARCHAR(50)  NOT NULL,
    email        VARCHAR(100),
    phone        VARCHAR(20),
    town         VARCHAR(50)  NOT NULL
);

CREATE TABLE bikes (
    bike_id      INT          PRIMARY KEY,
    customer_id  INT          NOT NULL,
    make         VARCHAR(50)  NOT NULL,
    model        VARCHAR(50)  NOT NULL,
    bike_type    VARCHAR(10)  NOT NULL,
    model_year   INT          NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    CHECK (bike_type IN ('MOUNTAIN', 'ROAD', 'GRAVEL', 'E-BIKE'))
);

-- job_id comes from the booking app.
-- labor_rate is stored per job so historical jobs keep the rate they were billed at.
CREATE TABLE jobs (
    job_id        INT           PRIMARY KEY,
    bike_id       INT           NOT NULL,
    job_date      DATE          NOT NULL,
    service_type  VARCHAR(20)   NOT NULL,
    labor_hours   NUMERIC(4, 2) NOT NULL,
    labor_rate    NUMERIC(6, 2) NOT NULL,
    status        VARCHAR(10)   NOT NULL,
    notes         VARCHAR(200),
    FOREIGN KEY (bike_id) REFERENCES bikes (bike_id),
    CHECK (service_type IN ('TUNE_UP', 'FLAT_REPAIR', 'BRAKE_SERVICE',
                            'DRIVETRAIN', 'SUSPENSION', 'WHEEL_TRUE')),
    CHECK (status IN ('COMPLETED', 'CANCELLED', 'IN_PROGRESS')),
    CHECK (labor_hours >= 0),   -- cancelled jobs have 0 hours and labor
    CHECK (labor_rate >= 0)
);

-- One row per part line on a job (a job can have zero or many).
CREATE TABLE parts (
    job_part_id  INT           PRIMARY KEY,
    job_id       INT           NOT NULL,
    part_name    VARCHAR(50)   NOT NULL,
    quantity     INT           NOT NULL,
    unit_cost    NUMERIC(8, 2) NOT NULL,  -- purchased value
    unit_price   NUMERIC(8, 2) NOT NULL,  -- priced value
    FOREIGN KEY (job_id) REFERENCES jobs (job_id),
    CHECK (quantity > 0)
);
