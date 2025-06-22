-- Create uber_requests table for initial data import
CREATE TABLE public.uber_requests
(
    request_id INTEGER,
    pickup_point VARCHAR(20),
    driver_id VARCHAR(10),
    status VARCHAR(30),
    request_timestamp VARCHAR(50),
    drop_timestamp VARCHAR(50)
);

-- Set ownership of the table to the postgres user
ALTER TABLE public.uber_requests OWNER to postgres;

-- Create index on request_id for better performance
CREATE INDEX idx_uber_requests_request_id ON public.uber_requests (request_id);

-- Additional useful indexes for analysis
CREATE INDEX idx_uber_requests_pickup_point ON public.uber_requests (pickup_point);
CREATE INDEX idx_uber_requests_status ON public.uber_requests (status);