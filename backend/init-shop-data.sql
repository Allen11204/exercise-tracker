-- ============================================
-- 初始化商城测试数据
-- ============================================
-- 注意: 请在后端启动后,连接数据库并执行此SQL脚本

-- 1. 清空已有商品数据(可选,如果需要重新初始化)
-- TRUNCATE TABLE shop_items;

-- 2. 更新现有用户的积分和地址信息(可选,如果已有用户需要初始积分)
-- UPDATE users SET points = 500, address = NULL, last_checkin_date = NULL WHERE id > 0;

-- 3. 插入健身商城商品数据
INSERT INTO shop_items (name, description, points_required, image_url, stock) VALUES
-- 运动装备系列
('专业护腕', '加压护腕,弹性透气,适合举重健身,提供腕部支撑保护', 280, 'https://images.unsplash.com/photo-1611672585731-fa10603fb9e0?w=400&h=300&fit=crop', 150),
('运动健身腰带', '加宽加厚举重腰带,护腰护腰椎,深蹲硬拉必备,尺码可调', 350, 'https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=400&h=300&fit=crop', 80),
('专业护膝', '运动护膝一对,篮球跑步健身专用,防滑透气加压保护', 300, 'https://images.unsplash.com/photo-1606889464198-fcb18894cf50?w=400&h=300&fit=crop', 100),
('护肘运动护具', '举重健身护肘,弹力加压,保护肘关节,一对装', 290, 'https://images.unsplash.com/photo-1599058918394-8dc3f8b6e04e?w=400&h=300&fit=crop', 90),

-- 健身器材系列
('阻力弹力带套装', '5条装健身弹力带,不同阻力等级,附门锚和收纳袋', 320, 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400&h=300&fit=crop', 70),
('瑜伽垫加厚防滑', '10mm加厚NBR瑜伽垫,环保材质,185cm超长,附背带', 340, 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400&h=300&fit=crop', 85),
('跳绳专业训练绳', '可调节轴承跳绳,防滑手柄,计数功能,适合减脂训练', 260, 'https://images.unsplash.com/photo-1598970434795-0c54fe7c0648?w=400&h=300&fit=crop', 120),
('哑铃家用健身', '环保浸塑哑铃2个装,3kg/5kg/8kg可选,防滑防摔', 380, 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?w=400&h=300&fit=crop', 60),

-- 运动配件系列
('智能健身手环', '心率监测睡眠追踪,50米防水,7天续航,运动模式丰富', 400, 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=400&h=300&fit=crop', 50),
('高级运动水杯', '不锈钢保温运动杯,750ml大容量,12小时保温,防漏设计', 300, 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=400&h=300&fit=crop', 100),
('运动背包大容量', '30L健身包,干湿分离,独立鞋仓,USB充电口,防水面料', 330, 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400&h=300&fit=crop', 65),
('速干运动毛巾', '超细纤维运动毛巾2条装,速干抗菌,柔软吸汗,附收纳袋', 270, 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=400&h=300&fit=crop', 130),

-- 营养补剂系列
('乳清蛋白粉', '高品质分离乳清蛋白,香草味2磅,增肌必备,易溶解', 390, 'https://images.unsplash.com/photo-1579722820308-d74e571900a9?w=400&h=300&fit=crop', 45),
('BCAA支链氨基酸', '运动前中后补充,减少肌肉分解,加速恢复,柠檬味', 360, 'https://images.unsplash.com/photo-1593095948071-474c5cc2989d?w=400&h=300&fit=crop', 55),
('肌酸粉健身补剂', '纯肌酸一水肌酸,300g装,增强爆发力和耐力', 310, 'https://images.unsplash.com/photo-1584464491033-06628f3a6b7b?w=400&h=300&fit=crop', 70),

-- 运动服饰系列
('健身手套专业款', '半指防滑健身手套,透气护腕,适合举重单杠训练', 285, 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400&h=300&fit=crop', 95),
('运动压缩衣', '速干透气压缩上衣,紧身设计,减少肌肉震动,提升表现', 340, 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=400&h=300&fit=crop', 75),
('跑步臂包手机包', '防水反光跑步手机臂包,适配6.5寸以下手机,触屏设计', 280, 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=400&h=300&fit=crop', 110),
('运动袜专业款', '中筒运动袜3双装,毛巾底减震,抗菌防臭,弹力好', 250, 'https://images.unsplash.com/photo-1586350977771-b3b0abd50c82?w=400&h=300&fit=crop', 140),

-- 康复训练系列
('泡沫轴筋膜放松', '45cm高密度泡沫轴,肌肉放松按摩,附使用教程', 295, 'https://images.unsplash.com/photo-1599058917212-d750089bc07e?w=400&h=300&fit=crop', 80);

-- 查看插入的商品
SELECT * FROM shop_items ORDER BY points_required;

-- 查看不同价格区间的商品数量
SELECT
    CASE
        WHEN points_required < 300 THEN '250-299积分'
        WHEN points_required < 350 THEN '300-349积分'
        WHEN points_required < 400 THEN '350-399积分'
        ELSE '400+积分'
    END AS price_range,
    COUNT(*) AS item_count,
    SUM(stock) AS total_stock
FROM shop_items
GROUP BY price_range
ORDER BY MIN(points_required);

-- 查看用户表结构(可选)
-- SELECT id, username, points, address, last_checkin_date FROM users;
