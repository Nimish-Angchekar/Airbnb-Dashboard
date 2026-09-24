create database airbnb;
 
use airbnb;
select * from listings;
select * from reviews;

select count(*) as total_listings from listings;

select count(*) as total_reviews from reviews;


# Listing table

describe listings;


select listing_id, host_id, host_since, host_response_rate, host_acceptance_rate, host_total_listings_count, latitude, 
       longitude, accommodates, bedrooms, price, minimum_nights, maximum_nights, review_scores_rating 
from listings
limit 10;


-- changing types
alter table listings
modify listing_id bigint,
modify host_id bigint,
modify host_since date,
modify latitude decimal(10,7),
modify longitude decimal(10,7),
modify accommodates int,
modify bedrooms decimal(5,2),
modify price decimal(10,2),
modify minimum_nights int,
modify maximum_nights int,
modify review_scores_rating decimal(5,2);


describe listings;
 

-- checking duplicates 
select listing_id, count(*) from listings
group by listing_id
having count(*)>1;


-- Null values 
select count(*) as total,
		sum(case when name is null or trim(name)='' then 1 else 0 end) as name_mising,
        sum(case when host_since is null or trim(host_since)='' then 1 else 0 end) as host_since_mising,
        SUM(CASE WHEN price is null or TRIM(price) = '' then 1 else 0 end) as missing_price,
		SUM(CASE WHEN bedrooms is null or TRIM(bedrooms) = '' then 1 else 0 end) as missing_bedrooms
from listings;


select
    COUNT(*) as total_rows,
    SUM(host_response_rate is null) as response_rate_null,
    SUM(host_acceptance_rate is null) as acceptance_rate_null,
    SUM(host_response_rate = '') as response_rate_blank,
    SUM(host_acceptance_rate = '') as acceptance_rate_blank
from listings;


SET SQL_SAFE_UPDATES = 0;


update listings
set host_response_rate = null
where listing_id is not null
and trim(host_response_rate) = '';

update listings
set host_acceptance_rate = null
where TRIM(host_acceptance_rate) = '';

alter table listings
modify host_response_rate decimal(5,2),
modify host_acceptance_rate decimal(5,2);

describe listings;


SET SQL_SAFE_UPDATES = 1;




# Reviews table
describe reviews;


select reviewer_id, count(*) from reviews
group by reviewer_id
having count(*)>1;


-- changing type 
alter table reviews
modify listing_id bigint,
modify review_id bigint,
modify reviewer_id bigint,
MODIFY `date` date;
