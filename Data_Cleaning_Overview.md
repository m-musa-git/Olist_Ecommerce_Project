## Checking for null values
To ensure the dataset is reliable, I first checked to see if there were any null values (more on that later). Next, I checked for whitespaces in any of the columns throughout the different tables. I decided it would be better to trim the whitespace for one of the tables after doing the following query: 

```
SELECT [product_category_name]
      ,[product_category_name_english]
  FROM [olist_ecommerce_project].[dbo].[product_category_name_translation]
WHERE [product_category_name] LIKE ' %'
  OR  [product_category_name_english] LIKE ' %'
```

And I trimmed the whitespace using the following queries:

``` 
UPDATE [olist_ecommerce_project].[dbo].[olist_order_reviews_dataset]
SET review_comment_title_trimmed = LTRIM(review_comment_title); 

UPDATE [olist_ecommerce_project].[dbo].[product_category_name_translation]
SET product_category_name_english = LTRIM(product_category_name_english); 
```

## Standardizing city names
And to ensure data standardization, I manually adjusted the names of some cities in the geolocation table by running the following query:

``` 
SELECT  DISTINCT [geolocation_city]  FROM [olist_ecommerce_project].[dbo].[olist_geolocation_dataset]
```
  
The above query had among other outputs the following cities: sao jose do rio preto and sÃ£josÃ©do rio preto . This was most likely due to the Portuguese alphabet format. As a result, I decided to standardize them based on their anglicized spelling.

``` 
UPDATE [olist_ecommerce_project].[dbo].[olist_geolocation_dataset]
SET geolocation_city = 'sao jose do rio preto' WHERE geolocation_city LIKE '%s%jos%do rio preto' 
```

## Addressing null values
Coming back to null values, in the products dataset, there were 610 rows where
product_category_name was null. So i decided to use the following query:

``` 
UPDATE [olist_ecommerce_project].[dbo].[olist_products_dataset]
SET product_category_name = 'unknown',
    product_category_name_english = 'unknown'
WHERE product_name_lenght IS NULL;
```

And more on null values, i decided to implement imputation for missing geospatial data. I checked for that missing data by running the following query: 

``` 
SELECT * FROM [olist_ecommerce_project].[dbo].[olist_geolocation_dataset]  WHERE geolocation_lat OR geolocation_lng IS NULL 
and from there i would check the instances where geolocation_lat was null and then run the following query: 
SELECT TOP (1000) [geolocation_zip_code_prefix]
      ,[geolocation_lat]
      ,[geolocation_lng]
      ,[geolocation_city]
      ,[geolocation_state]
  FROM [olist_ecommerce_project].[dbo].[olist_geolocation_dataset]   WHERE  geolocation_city like 'raposo'
```

Which gave the following output:

``` 
geolocation_zip_code_prefix	geolocation_lat	         geolocation_lng	      geolocation_city	   geolocation_state
28333	                        -21.0971584320068	        -42.1128921508789	            raposo               RJ
28333	                           NULL	                       -6.328200340271	               raposo               RJ
28333	                        -21.1019268035889	        -42.1158103942871	            raposo               RJ
28333	                        -21.1003036499023	        -42.1128082275391	            raposo	         RJ
28333	                        -21.0974445343018	        -42.1086349487305	            raposo	         RJ
28333	                        -21.1019268035889	        -42.1158103942871	            raposo	         RJ
```


I would then impute based on the average latitude value which I did using the following query:

 ``` 
-- Create a temporary table with average lat/lng by zip prefix
WITH zip_geo_avg AS (

  SELECT 
    geolocation_zip_code_prefix,
    AVG(geolocation_lat) AS avg_lat,
    AVG(geolocation_lng) AS avg_lng
    
  FROM 
    [olist_ecommerce_project].[dbo].[olist_geolocation_dataset]  WHERE 
     geolocation_lat IS NOT NULL
    AND geolocation_lng IS NOT NULL
    GROUP BY
   geolocation_zip_code_prefix
),

-- For zip prefixes with no data, get city/state averages
city_geo_avg AS (
  SELECT 
    geolocation_city,
    geolocation_state,
    AVG(geolocation_lat) AS avg_lat,
    AVG(geolocation_lng) AS avg_lng
  FROM 
    olist_geolocation_dataset
  WHERE 
    geolocation_lat IS NOT NULL
    AND geolocation_lng IS NOT NULL
  GROUP BY 
    geolocation_city, geolocation_state
)

-- Update missing values hierarchically
UPDATE g
SET 
  geolocation_lat = 
    CASE 
      WHEN g.geolocation_lat IS NULL AND z.avg_lat IS NOT NULL THEN z.avg_lat
      WHEN g.geolocation_lat IS NULL AND c.avg_lat IS NOT NULL THEN c.avg_lat
      ELSE g.geolocation_lat -- Keep original if no imputation available
    END
FROM 
  [olist_ecommerce_project].[dbo].[olist_geolocation_dataset] g
LEFT JOIN 
  zip_geo_avg z ON g.geolocation_zip_code_prefix = z.geolocation_zip_code_prefix
LEFT JOIN 
  city_geo_avg c ON g.geolocation_city = c.geolocation_city 
                 AND g.geolocation_state = c.geolocation_state
WHERE 
  g.geolocation_lat IS NULL;
```
