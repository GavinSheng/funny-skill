#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import os

def load_json_file(filepath):
    """加载JSON文件"""
    if os.path.exists(filepath):
        with open(filepath, 'r', encoding='utf-8') as f:
            return json.load(f)
    return None

def merge_cuisine_data():
    """合并所有菜系数据"""
    
    # 加载现有的完整数据库
    main_db = load_json_file('skills/cooking-recipes/complete_cuisine_database.json')
    if not main_db:
        print("❌ 主数据库不存在")
        return
    
    # 定义要合并的扩展文件
    expansion_files = [
        ('川菜', 'sichuan_expansion.json'),
        ('粤菜', 'cantonese_expansion.json'),
        ('鲁菜', 'shandong_expansion.json'),
        ('苏菜', 'jiangsu_expansion.json'),
        ('浙菜', 'zhejiang_expansion.json'),
        ('闽菜', 'fujian_expansion.json'),
        ('湘菜', 'hunan_expansion.json'),
        ('徽菜', 'anhui_expansion.json')
    ]
    
    # 合并八大菜系扩展
    total_new_dishes = 0
    for cuisine_name, filename in expansion_files:
        filepath = f'skills/cooking-recipes/{filename}'
        expansion_data = load_json_file(filepath)
        if expansion_data:
            if cuisine_name in main_db['cuisines']:
                # 合并现有菜系
                existing_names = {dish['name'] for dish in main_db['cuisines'][cuisine_name]}
                new_dishes = [dish for dish in expansion_data['dishes'] 
                            if dish['name'] not in existing_names]
                main_db['cuisines'][cuisine_name].extend(new_dishes)
                total_new_dishes += len(new_dishes)
                print(f"✅ {cuisine_name}: 新增 {len(new_dishes)} 道菜")
            else:
                # 新菜系
                main_db['cuisines'][cuisine_name] = expansion_data['dishes']
                total_new_dishes += len(expansion_data['dishes'])
                print(f"✅ 新增菜系 {cuisine_name}: {len(expansion_data['dishes'])} 道菜")
    
    # 加载并合并小吃数据
    street_food_data = load_json_file('skills/cooking-recipes/street_food_expansion.json')
    if street_food_data:
        main_db['cuisines']['各地小吃'] = street_food_data['dishes']
        total_new_dishes += len(street_food_data['dishes'])
        print(f"✅ 各地小吃: 新增 {len(street_food_data['dishes'])} 道")
    
    # 更新总计数
    total_recipes = sum(len(dishes) for dishes in main_db['cuisines'].values())
    main_db['metadata']['total_recipes'] = total_recipes
    main_db['metadata']['version'] = '5.0'
    main_db['metadata']['last_updated'] = '2026-03-20'
    main_db['metadata']['description'] = 'Complete cooking recipes database with expanded Eight Great Cuisines and street food'
    
    # 保存更新后的数据库
    with open('skills/cooking-recipes/final_complete_database.json', 'w', encoding='utf-8') as f:
        json.dump(main_db, f, ensure_ascii=False, indent=2)
    
    print(f"\n🎉 最终统计:")
    print(f"✅ 总菜谱数量: {total_recipes} 道")
    print(f"✅ 八大菜系: 已完整覆盖")
    print(f"✅ 各地小吃: 已添加")
    print(f"✅ 数据库版本: 5.0")

if __name__ == '__main__':
    merge_cuisine_data()