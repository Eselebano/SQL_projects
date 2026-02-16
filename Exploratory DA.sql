-- Exploratory Data Analysis
-- Total Sales BY sales agent
SELECT s.sales_agent, SUM(p.close_value) total_sales
FROM sales_pipelines p
JOIN teams_for_sales s ON p.sales_agent = s.sales_agent
WHERE p.deal_stage = "Won"
GROUP BY s.sales_agent
ORDER BY total_sales DESC;

SELECT * 
FROM sales_pipelines;

-- Sales by regional ofice
SELECT s.regional_office, SUM(p.close_value) regional_sales
FROM sales_pipelines p
JOIN teams_for_sales s ON p.sales_agent = s.sales_agent
WHERE p.deal_stage = "Won"
GROUP BY s.regional_office
ORDER BY regional_sales DESC;

-- Win rate by sales agent
SELECT sales_agent,
       COUNT(*) as total_deals,
       SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) as won_deals,
       ROUND(SUM(CASE WHEN deal_stage = 'Won' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as win_rate
FROM sales_pipelines
GROUP BY sales_agent;

SELECT * 
FROM sales_pipelines;

-- Most Profitable products
SELECT pr.product, pr.series, SUM(sp.close_value) total_revenue
FROM sales_pipelines sp
JOIN people_products pr ON sp.product = pr.product
WHERE sp.deal_stage = "Won"
GROUP BY pr.product, pr.series
ORDER BY total_revenue DESC;

-- Monthly sales
SELECT MONTH(close_date) `month`,
 COUNT(*) as deals_won, SUM(close_value) as monthly_revenue
FROM sales_pipelines
WHERE deal_stage = "Won"
GROUP BY MONTH(close_date)
ORDER BY `month`;