#!/usr/bin/env python3
import json
import os

# 读取现有的完整菜谱数据库
with open('skills/cooking-recipes/chinese_cuisine_complete.json', 'r', encoding='utf-8') as f:
    existing_data = json.load(f)

# 读取新增的川菜和滇菜
with open('skills/cooking-recipes/sichuan_cuisine_expanded.json', 'r', encoding='utf-8') as f:
    sichuan_data = json.load(f)

with open('skills/cooking-recipes/yunnan_cuisine_expanded.json', 'r', encoding='utf-8') as f:
    yunnan_data = json.load(f)

# 合并数据
all_recipes = existing_data['recipes'].copy()

# 添加新的川菜（避免重复）
sichuan_names = {recipe['name'] for recipe in all_recipes if recipe.get('cuisine') == '川菜'}
for recipe in sichuan_data['recipes']:
    if recipe['name'] not in sichuan_names:
        all_recipes.append(recipe)

# 添加新的滇菜
yunnan_names = {recipe['name'] for recipe in all_recipes if recipe.get('cuisine') == '滇菜'}
for recipe in yunnan_data['recipes']:
    if recipe['name'] not in yunnan_names:
        all_recipes.append(recipe)

# 更新元数据
total_count = len(all_recipes)
sichuan_count = len([r for r in all_recipes if r.get('cuisine') == '川菜'])
yunnan_count = len([r for r in all_recipes if r.get('cuisine') == '滇菜'])

updated_data = {
    "metadata": {
        "total_recipes": total_count,
        "cuisines": ["川菜", "滇菜", "粤菜", "鲁菜", "苏菜", "浙菜", "闽菜", "湘菜", "徽菜", "京菜", "沪菜", "东北菜", "西北菜", "清真菜", "素斋"],
        "sichuan_dishes": sichuan_count,
        "yunnan_dishes": yunnan_count,
        "mahansheen_complete": True,
        "last_updated": "2026-03-19",
        "version": "4.0"
    },
    "recipes": all_recipes
}

# 保存更新后的数据库
with open('skills/cooking-recipes/chinese_cuisine_final.json', 'w', encoding='utf-8') as f:
    json.dump(updated_data, f, ensure_ascii=False, indent=2)

print(f"✅ 菜谱数据库更新完成！")
print(f"总菜谱数量: {total_count} 道")
print(f"川菜数量: {sichuan_count} 道")
print(f"滇菜数量: {yunnan_count} 道")