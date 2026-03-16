-- SQL Case Study
-- Website Conversion Performance Analysis

-- Main Business Question

-- How effectively does website traffic convert into purchases, and where can the conversion process be improved?
-- This analysis explores:

-- 1. Website traffic sources
-- 2. Overall conversion rate
-- 3. Marketing channel performance
-- 4. Campaign performance
-- 5. Device performance
-- 6. Page popularity
-- 7. Funnel drop-off analysis
-- 8. Product revenue performance
-- 9. Product profitability


-- 1. Website Traffic Sources
-- Question: Where do website visitors come from?

SELECT
    utm_source,
    COUNT(*) AS total_sessions
FROM website_sessions
GROUP BY utm_source
ORDER BY total_sessions DESC;

-- Insight
-- The majority of website traffic originates from Google search advertising (gsearch), making it the primary source of visitor acquisition.


-- 2. Overall Conversion Rate
-- Question: What percentage of website visitors place an order?

SELECT
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0 /
        COUNT(DISTINCT ws.website_session_id),
        2
    ) AS conversion_rate_percentage
FROM website_sessions ws
LEFT JOIN orders o
USING (website_session_id);

-- Insight
-- Approximately 7% of website visitors complete a purchase, meaning that out of every 100 sessions, around 7 result in an order.



-- 3. Conversion Rate by Traffic Source
-- Question: Which traffic source converts best?

SELECT
    ws.utm_source,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id) * 100.0 / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate_percentage
FROM website_sessions ws
LEFT JOIN orders o
USING (website_session_id)
GROUP BY ws.utm_source
ORDER BY conversion_rate_percentage DESC;


-- Insight
-- Sessions without a tracked source (direct traffic) show the highest conversion rate at 7.34%, 
-- indicating strong purchase intent from returning or brand-aware visitors.
-- While Google search advertising generates the majority of traffic and orders, social media campaigns show the lowest conversion rate, 
-- suggesting lower purchase intent.


-- 4. Marketing Campaign Performance
-- Question: Which marketing campaigns perform best?

SELECT
    ws.utm_source,
    ws.utm_campaign,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(
        COUNT(DISTINCT o.order_id) * 100.0 /
        COUNT(DISTINCT ws.website_session_id),
        2
    ) AS conversion_rate_percentage
FROM website_sessions ws
LEFT JOIN orders o
USING (website_session_id)
GROUP BY ws.utm_source, ws.utm_campaign
ORDER BY conversion_rate_percentage DESC;

-- Insight
-- Brand search campaigns deliver the highest conversion rates, with Bing brand campaigns reaching 8.86%.
-- Meanwhile, Google non-brand campaigns generate the highest volume of traffic and orders, making them critical for customer acquisition.
-- Social media campaigns demonstrate weaker performance, indicating potential issues with targeting or audience intent.


-- 5. Device Performance
-- Question: Which device converts better?

SELECT
    ws.device_type,
    COUNT(DISTINCT ws.website_session_id) AS sessions,
    COUNT(DISTINCT o.order_id) AS orders,
    ROUND(COUNT(DISTINCT o.order_id) * 100.0 / COUNT(DISTINCT ws.website_session_id), 2) AS conversion_rate_percentage
FROM website_sessions ws
LEFT JOIN orders o
USING (website_session_id)
GROUP BY ws.device_type
ORDER BY conversion_rate_percentage DESC;


-- Insight
-- Desktop users convert at 8.50%, significantly higher than mobile users at 3.09%.
-- Although mobile represents a large share of traffic, its lower conversion rate suggests possible usability or checkout friction on mobile devices.


-- 6. Most Visited Pages
-- Question: Which pages receive the most traffic?

SELECT
    pageview_url,
    COUNT(*) AS total_pageviews
FROM website_pageviews
GROUP BY pageview_url
ORDER BY total_pageviews DESC;


-- Insight
-- The product listing page receives the highest traffic, indicating that users frequently browse the catalog before selecting specific items.
-- High engagement on product pages such as The Original Mr. Fuzzy highlights strong interest in flagship products.
-- However, the large gap between product views and cart visits suggests opportunities to improve product page persuasion.


-- 7. Purchase Funnel Analysis
-- Question: Where do users drop off in the checkout process?

WITH funnel AS (
    SELECT
        website_session_id,

        MAX(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS products_page,
        MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) AS cart_page,
        MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) AS shipping_page,
        MAX(CASE WHEN pageview_url = '/billing-2' THEN 1 ELSE 0 END) AS billing_page,
        MAX(CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END) AS order_complete

    FROM website_pageviews
    GROUP BY website_session_id
)

SELECT
    COUNT(*) AS total_sessions,
    SUM(products_page) AS product_page_visits,
    SUM(cart_page) AS cart_visits,
    SUM(shipping_page) AS shipping_visits,
    SUM(billing_page) AS billing_visits,
    SUM(order_complete) AS orders
FROM funnel;

-- Funnel Conversion Rates
-- Session → Product Page: 55%
-- Product Page → Cart: 36%
-- Cart → Shipping: 68%
-- Shipping → Billing: 75%
-- Billing → Order: 67%

-- Insight
-- The largest drop-off occurs between the product page and cart stage, where only 36% of visitors add items to their cart.
-- This suggests potential friction on the product page, such as pricing hesitation, unclear value propositions, or weak call-to-action visibility.



-- 8. Product Revenue Analysis
-- Question: Which products generate the most revenue?

SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS units_sold,
    ROUND(SUM(oi.price_usd),2) AS total_revenue
FROM order_items oi
JOIN products p
USING (product_id)
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Insight
-- The Original Mr. Fuzzy generates the highest revenue, exceeding $1.2M, significantly outperforming all other products.
-- This indicates that the company relies heavily on this flagship product for sales performance.




-- 9. Product Profitability
-- Question: Which products generate the most profit?


SELECT
    p.product_name,
    COUNT(oi.order_item_id) AS units_sold,
    ROUND(SUM(oi.price_usd),2) AS total_revenue,
    ROUND(SUM(oi.price_usd - oi.cogs_usd),2) AS total_profit
FROM order_items oi
JOIN products p
USING (product_id)
GROUP BY p.product_name
ORDER BY total_profit DESC;

-- Insight
-- The Original Mr. Fuzzy is also the most profitable product, generating over $738K in profit.
-- This reinforces its importance as the company's flagship product while also highlighting potential risk from overdependence on a single product.



-- Final Conclusion

-- Overall analysis shows that the website converts approximately 7% of visitors into customers, 
-- with search advertising driving the majority of traffic and sales.
-- However, the largest opportunity for improvement lies in the product page stage of the funnel, 
-- where many users browse products but do not proceed to add items to their cart.

-- Additionally, both revenue and profit are heavily concentrated in one flagship product — The Original Mr. Fuzzy, 
-- indicating strong performance but also potential dependency risk.































