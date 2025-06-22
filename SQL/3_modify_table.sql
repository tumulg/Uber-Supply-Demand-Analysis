/*
Loading Uber dataset using the PSQLTool in pgAdmin4
1. Open pgAdmin
2. In Object Explorer (left-hand pane), navigate to `uber` database
3. Right-click `uber` and select `PSQL Tool`
    - This opens a terminal window to write the following code
4. Get the absolute file path of your csv file
    - Find path by right-clicking CSV file in VS Code and selecting "Copy Path"
5. Paste the following into `PSQL Tool` (with the CORRECT file path):
*/

SET datestyle = 'MDY';

-- Uber Requests Data
\copy uber_requests FROM 'C:\Work\Labmentix\Labmentix - Uber Analysis\Dataset\uber_request_data_copy.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'N/A');

/*
OR

Just run the following query:
*/

-- Uber Requests Data
\copy uber_requests 
FROM 'C:\Your\Path\To\uber_requests_copy.csv' -- Note: Replace with your actual path
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8', NULL 'N/A');

/*
Note: If you get error:
'could not open file "[your file path]\uber_requests_copy.csv" for reading: Permission denied.'
I highly recommend you to load the dataset using the PSQLTool in pgAdmin4
*/

/*
Data Quality Adjustments Made:
- uber_requests: Using NULL 'N/A' to handle N/A values in driver_id column
- Mixed timestamp formats will be handled in subsequent cleaning queries
These adjustments ensure successful data import while maintaining analytical integrity.
*/