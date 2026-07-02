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

def save_json_file(data, filepath):
    """保存JSON文件"""
    with open(filepath, 'w', encoding='utf-8') as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

def main():
    # 加载现有菜谱数据库
    main_db = load_json_file('skills/cooking-recipes/comprehensive_recipes.json')
    
    # 加载川菜扩展
    sichuan_expanded = load_json_file('skills/cooking-recipes/sichuan_cuisine_expanded.json')
    
    # 加载滇菜扩展  
    yunnan_expanded = load_json_file('skills/cooking-recipes/yunnan_cuisine_expanded.json')
    
    if not main_db:
        print("❌ 主数据库不存在")
        return
    
    # 获取现有的菜谱列表
    existing_recipes = main_db.get('recipes', [])
    
    # 创建菜谱名称集合用于去重
    existing_names = {recipe['name'] for recipe in existing_recipes}
    
    # 添加新的川菜菜谱
    new_sichuan_count = 0
    if sichuan_expanded and 'recipes' in sichuan_expanded:
        for recipe in sichuan_expanded['recipes']:
            if recipe['name'] not in existing_names:
                existing_recipes.append(recipe)
                existing_names.add(recipe['name'])
                new_sichuan_count += 1
    
    # 添加新的滇菜菜谱
    new_yunnan_count = 0
    if yunnan_expanded and 'recipes' in yunnan_expanded:
        for recipe in yunnan_expanded['recipes']:
            if recipe['name'] not in existing_names:
                existing_recipes.append(recipe)
                existing_names.add(recipe['name'])
                new_yunnan_count += 1
    
    # 更新元数据
    main_db['recipes'] = existing_recipes
    main_db['metadata']['total_recipes'] = len(existing_recipes)
    main_db['metadata']['last_updated'] = '2026-03-19'
    main_db['metadata']['version'] = '3.0'
    main_db['metadata']['sichuan_dishes_added'] = new_sichuan_count
    main_db['metadata']['yunnan_dishes_added'] = new_yunnan_count
    
    # 保存更新后的数据库
    save_json_file(main_db, 'skills/cooking-recipes/comprehensive_recipes.json')
    
    print(f"✅ 菜谱数据库更新完成！")
    print(f"总菜谱数量: {len(existing_recipes)} 道")
    print(f"新增川菜: {new_sichuan_count} 道")  
    print(f"新增滇菜: {new_yunnan_count} 道")

if __name__ == "__main__":
    main()