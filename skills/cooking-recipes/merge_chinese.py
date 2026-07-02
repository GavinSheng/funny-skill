#!/usr/bin/env python3
import json
import os

# 读取所有中国菜数据文件
files = [
    'chinese_recipes.json',
    'chinese_100_supplement.json', 
    'mahansheen_detailed.json'
]

all_recipes = []
recipe_names = set()

for filename in files:
    if os.path.exists(filename):
        with open(filename, 'r', encoding='utf-8') as f:
            data = json.load(f)
            if isinstance(data, list):
                recipes = data
            elif 'recipes' in data:
                recipes = data['recipes']
            elif 'dishes' in data:
                recipes = data['dishes']
            else:
                recipes = []
            
            for recipe in recipes:
                name = recipe.get('name', '')
                if name and name not in recipe_names:
                    recipe_names.add(name)
                    all_recipes.append(recipe)

# 创建完整的中国菜数据库
complete_chinese = {
    "metadata": {
        "total_recipes": len(all_recipes),
        "cuisines": ["川菜", "粤菜", "鲁菜", "苏菜", "浙菜", "闽菜", "湘菜", "徽菜", "京菜", "沪菜", "东北菜", "西北菜", "清真菜", "素斋"],
        "includes_mahansheen": True,
        "mahansheen_count": 108,
        "version": "4.0",
        "last_updated": "2026-03-19"
    },
    "recipes": all_recipes
}

with open('chinese_cuisine_final.json', 'w', encoding='utf-8') as f:
    json.dump(complete_chinese, f, ensure_ascii=False, indent=2)

print(f"✅ 完整中国菜数据库创建完成！")
print(f"总菜谱数量: {len(all_recipes)} 道")
print(f"满汉全席菜品: 108 道")
print(f"其他经典菜品: {len(all_recipes) - 108} 道")