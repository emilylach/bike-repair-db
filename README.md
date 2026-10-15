# Mobile Bike Repair Database

A SQL Server database for a fictional small bike repair business in Colorado. It covers the schema, a year of sample data, business reporting
queries, a daily load from the booking app with validation, and data quality checks.

All customer data is fictional.

## Database Schema
```
    CUSTOMERS {
        int customer_id PK
        varchar first_name
        varchar last_name
        varchar email
        varchar phone
        varchar town
    }

    BIKES {
        int bike_id PK
        int customer_id
        varchar make
        varchar model
        varchar bike_type
        int model_year
    }

    JOBS {
        int job_id PK
        int bike_id
        date job_date
        varchar service_type
        numeric labor_hours
        numeric labor_rate
        varchar status
        varchar notes 
    }

    PARTS {
        int part_id PK
        int job_id
        varchar part_name
        int quantity
        numeric unit_cost
        numeric unit_price
    }
