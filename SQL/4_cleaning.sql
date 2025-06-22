-- Data Cleaning
SELECT 
    *
FROM 
    uber_requests;

/*
UBER REQUESTS DATA - COLUMN ANALYSIS COMPLETE
==============================================
Column 1: request_id
- 6,745 unique IDs, no nulls, range 1-6766

Column 2: pickup_point
- Clean categorical: City (3,507), Airport (3,238)

Column 3: driver_id
- 301 numeric drivers + logical "NA" for unavailable cars (2,650)

Column 4: status
- Trip Completed (41.97%), No Cars Available (39.29%), Cancelled (18.74%)

Column 5: request_timestamp STANDARDIZED
- Mixed formats converted to request_timestamp_clean (TIMESTAMP)

Column 6: drop_timestamp STANDARDIZED  
- Logical "NA" for incomplete trips, standardized to drop_timestamp_clean (TIMESTAMP)
*/

/*
DERIVED COLUMNS CREATED SUCCESSFULLY:
=====================================

1. Extracted request_hour from request_timestamp_clean
2. Based on the request_hour, derived a new time_slot category volumn

Peak Hours Identified:
- Highest demand: 18:00 (6 PM) = 510 requests
- Early morning rush: 5-7 AM = 1,249 requests  
- Evening rush: 17-19 PM = 1,401 requests
- Late evening: 20-21 PM = 941 requests

Time Slot Totals:
- Night (0-3): 375 requests
- Early Morning (4-7): 1,452 requests  
- Morning (8-11): 1,268 requests
- Afternoon (12-15): 651 requests
- Evening (16-19): 1,560 requests
- Late Evening (20-21): 941 requests
- Late Night (22-23): 498 requests

TOTAL: 6,745 requests
*/

-- 1. request_id:
SELECT 
    COUNT(*) as total_rows,
    COUNT(request_id) as non_null_count,
    COUNT(DISTINCT(request_id)) as unique_values,
    MIN(request_id) as min_value,
    MAX(request_id) as max_value
FROM
    uber_requests;
/*
Insights:
1. Total rows: 6,745
2. No nulls: All 6,745 have values
3. All unique: 6,745 unique IDs
4. Range: 1 to 6,766 (some gaps, but that's normal)
- request_id column is clean and ready!
*/

-- 2. pickup_point:
SELECT 
    COUNT(*) as total_rows,
    COUNT(pickup_point) as non_null_count,
    pickup_point,
    COUNT(*) as count_per_value
FROM 
    uber_requests 
GROUP BY 
    pickup_point
ORDER BY 
    count_per_value DESC;
/*
Insights:
1. Total rows: 6,745 (3,507 + 3,238)
2. No nulls: All have values
3. Clean categorical values: Only "City" and "Airport"
4. Distribution: City 3,507 (52%), Airport 3,238 (48%)
- pickup_point column is clean and ready!
*/

-- 3. driver_id:
SELECT 
    COUNT(*) as total_rows,
    COUNT(driver_id) as non_null_count,
    COUNT(*) - COUNT(driver_id) as null_count,
    COUNT(DISTINCT driver_id) as unique_drivers,
    MIN(driver_id) as min_driver_id,
    MAX(driver_id) as max_driver_id
FROM 
    uber_requests 
WHERE 
    driver_id IS NOT NULL 
AND 
    driver_id != ''
AND 
    driver_id != 'NA';

-- Check what values are in driver_id column
SELECT 
    driver_id,
    COUNT(*) as count
FROM 
    uber_requests 
GROUP BY 
    driver_id 
ORDER BY 
    count DESC
LIMIT 10;

-- Check which statuses have 'NA' driver_id
SELECT 
    status,
    driver_id,
    COUNT(*) as count
FROM uber_requests 
WHERE driver_id = 'NA'
GROUP BY status, driver_id;
/*
Insights:
1. Mixed data types: 301 unique numeric driver IDs + "NA" values
2. "NA" values: 2,650 records (39% of data)
3. Business logic confirmed: ALL "NA" values correspond to "No Cars Available" status
4. Driver workload: Most drivers handle 20-22 trips each
5. Range: Numeric drivers from 1 to 301
- driver_id column has expected pattern - logical "NA" for unavailable cars!
*/

-- 4. status:
SELECT 
    COUNT(*) as total_rows,
    COUNT(status) as non_null_count,
    status,
    COUNT(*) as count_per_status,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM uber_requests), 2) as percentage
FROM 
    uber_requests 
GROUP BY 
    status
ORDER BY 
    count_per_status DESC;
/*
Insights:
1. Total rows: 6,745 (2,831 + 2,650 + 1,264)
2. No nulls: All have values
3. Three status categories: "Trip Completed", "No Cars Available", "Cancelled"
4. Distribution: 
   - Trip Completed: 2,831 (41.97%) - Successful rides
   - No Cars Available: 2,650 (39.29%) - Supply shortage
   - Cancelled: 1,264 (18.74%) - Driver/customer cancellations
5. Key insight: ~58% of requests fail (No Cars + Cancelled)
- status column is clean and ready!
*/

-- 5. request_timestamp
SELECT 
    COUNT(*) as total_rows,
    COUNT(request_timestamp) as non_null_count,
    COUNT(*) - COUNT(request_timestamp) as null_count
FROM 
    uber_requests;

-- Check timestamp format distribution
SELECT 
    CASE 
        WHEN request_timestamp LIKE '%/%' THEN 'MM/DD/YYYY Format'
        WHEN request_timestamp LIKE '%-%' THEN 'DD-MM-YYYY Format'
        ELSE 'Other Format'
    END as format_type,
    COUNT(*) as count_per_format
FROM 
    uber_requests 
GROUP BY 
    format_type;
/*
Insights:
1. Total rows: 6,745 (need basic count first)
2. No nulls: All have timestamp values (assuming from previous pattern)
3. Mixed timestamp formats detected:
   - DD-MM-YYYY Format: 4,071 records (60.3%)
   - MM/DD/YYYY Format: 2,674 records (39.7%)
4. Data cleaning required: Need to standardize both formats
5. Examples: "13-07-2016 08:33:16" vs "11/7/2016 11:51"
- request_timestamp column needs format standardization!
*/

-- Add new column for standardized request timestamp
ALTER TABLE uber_requests 
ADD COLUMN request_timestamp_clean TIMESTAMP;

-- Update standardized timestamp handling both formats
UPDATE uber_requests 
SET request_timestamp_clean = 
    CASE 
        -- Handle MM/DD/YYYY format (contains '/')
        WHEN request_timestamp LIKE '%/%' THEN 
            TO_TIMESTAMP(request_timestamp, 'MM/DD/YYYY HH24:MI')
        -- Handle DD-MM-YYYY format (contains '-')
        WHEN request_timestamp LIKE '%-%' THEN 
            TO_TIMESTAMP(request_timestamp, 'DD-MM-YYYY HH24:MI:SS')
        ELSE NULL
    END;

-- Check if standardization worked
SELECT 
    request_timestamp,
    request_timestamp_clean,
    COUNT(*) as count
FROM 
    uber_requests 
GROUP BY 
    request_timestamp, 
    request_timestamp_clean
ORDER BY 
    count DESC; 
-- request_timestamp column standardized and ready!

-- 6. drop_timestamp:
SELECT 
    COUNT(*) as total_rows,
    COUNT(drop_timestamp) as non_null_count,
    COUNT(*) - COUNT(drop_timestamp) as null_count
FROM 
    uber_requests;

-- Check drop_timestamp format distribution
SELECT 
    CASE 
        WHEN drop_timestamp LIKE '%/%' THEN 'MM/DD/YYYY Format'
        WHEN drop_timestamp LIKE '%-%' THEN 'DD-MM-YYYY Format'
        ELSE 'Other Format'
    END as format_type,
    COUNT(*) as count_per_format
FROM 
    uber_requests 
GROUP BY 
    format_type;

-- Check what's in the "Other Format" category
SELECT 
    drop_timestamp,
    COUNT(*) as count
FROM 
    uber_requests 
WHERE 
    drop_timestamp NOT LIKE '%/%' 
AND drop_timestamp NOT LIKE '%-%'
GROUP BY 
    drop_timestamp
ORDER BY 
    count DESC
LIMIT 10;

-- Verify drop_timestamp logic by status
SELECT 
    status,
    CASE 
        WHEN drop_timestamp = 'NA' THEN 'No Drop Time'
        ELSE 'Has Drop Time'
    END as drop_time_status,
    COUNT(*) as count
FROM 
    uber_requests 
GROUP BY status, 
    CASE 
        WHEN drop_timestamp = 'NA' THEN 'No Drop Time'
        ELSE 'Has Drop Time'
    END
ORDER BY 
    status, 
    drop_time_status;
/*
Insights:
1. Total rows: 6,745
2. Business logic validated:
   - "Trip Completed": 2,831 records WITH drop times
   - "Cancelled": 1,264 records with "NA" (no drop time - logical!)
   - "No Cars Available": 2,650 records with "NA" (no drop time - logical!)
3. Mixed formats in actual timestamps: DD-MM-YYYY (1,681) + MM/DD/YYYY (1,150)
4. "NA" values: 3,914 records (58% - matches failed trip rate)
- drop_timestamp column has correct business logic!
- drop_timestamp column needs format standardization!
*/

-- Add new column for standardized drop timestamp
ALTER TABLE uber_requests 
ADD COLUMN drop_timestamp_clean TIMESTAMP;

-- Update standardized drop timestamp (only for non-NA values)
UPDATE uber_requests 
SET drop_timestamp_clean = 
    CASE 
        WHEN drop_timestamp = 'NA' THEN NULL
        -- Handle MM/DD/YYYY format (contains '/')
        WHEN drop_timestamp LIKE '%/%' THEN 
            TO_TIMESTAMP(drop_timestamp, 'MM/DD/YYYY HH24:MI')
        -- Handle DD-MM-YYYY format (contains '-')
        WHEN drop_timestamp LIKE '%-%' THEN 
            TO_TIMESTAMP(drop_timestamp, 'DD-MM-YYYY HH24:MI:SS')
        ELSE NULL
    END;

-- Check if standardization worked
SELECT 
    drop_timestamp,
    drop_timestamp_clean,
    COUNT(*) as count
FROM 
    uber_requests 
GROUP BY 
    drop_timestamp, 
    drop_timestamp_clean
ORDER BY 
    count DESC; 
-- drop_timestamp column standardized and ready!

-- Add hour extraction from request timestamp
ALTER TABLE uber_requests 
ADD COLUMN request_hour INTEGER;

-- Add time slot categorization
ALTER TABLE uber_requests 
ADD COLUMN time_slot VARCHAR(20);

-- Extract hour (0-23) from standardized request timestamp
UPDATE uber_requests 
SET request_hour = EXTRACT(HOUR FROM request_timestamp_clean);

-- Create time slot categories
UPDATE uber_requests 
SET time_slot = 
    CASE 
        WHEN request_hour >= 0 AND request_hour <= 3 THEN 'Night'
        WHEN request_hour >= 4 AND request_hour <= 7 THEN 'Early Morning'
        WHEN request_hour >= 8 AND request_hour <= 11 THEN 'Morning'
        WHEN request_hour >= 12 AND request_hour <= 15 THEN 'Afternoon'
        WHEN request_hour >= 16 AND request_hour <= 19 THEN 'Evening'
        WHEN request_hour >= 20 AND request_hour <= 21 THEN 'Late Evening'
        WHEN request_hour >= 22 AND request_hour <= 23 THEN 'Late Night'
        ELSE 'Unknown'
    END;

-- Check the derived columns
SELECT 
    request_hour,
    time_slot,
    COUNT(*) as count
FROM 
    uber_requests 
GROUP BY 
    request_hour, 
    time_slot
ORDER BY 
    request_hour;