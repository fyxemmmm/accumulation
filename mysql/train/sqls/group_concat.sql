SELECT * FROM `reviews`


select GROUP_CONCAT(ids) ids from (
SELECT  GROUP_CONCAT(r_id) ids, count(*) as c, r_content, r_userid from reviews GROUP BY r_content, r_userid having c > 1
) a