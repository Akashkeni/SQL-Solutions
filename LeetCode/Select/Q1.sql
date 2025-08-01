-- Recyclable and Low Fat Products

select product_id from products
where low_fats = "Y" and recyclable = "Y"

order by product_id;