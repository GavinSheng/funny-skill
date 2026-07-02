#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json

# 读取现有的完整数据库
with open('skills/cooking-recipes/complete_cuisine_database.json', 'r', encoding='utf-8') as f:
    complete_db = json.load(f)

# 读取新的完整云南菜谱
with open('skills/cooking-recipes/yunnan_cuisine_complete.json', 'r', encoding='utf-8') as f:
    yunnan_db = json.load(f)

# 更新云南菜部分
complete_db['cuisines']['云南菜'] = yunnan_db['dishes']

# 更新总数量统计
yunnan_count = len(yunnan_db['dishes'])
sichuan_count = len(complete_db['cuisines']['川菜'])
other_count = 174 - 15 - 15  # 原来的其他菜系数量
complete_db['metadata']['total_recipes'] = other_count + sichuan_count + yunnan_count
complete_db['metadata']['version'] = '4.1'
complete_db['metadata']['last_updated'] = '2026-03-19'

# 保存更新后的数据库
with open('skills/cooking-recipes/complete_cuisine_database.json', 'w', encoding='utf-8') as f:
    json.dump(complete_db, f, ensure_ascii=False, indent=2)

print(f"✅ 云南菜谱更新完成！")
print(f"四川菜数量: {sichuan_count} 道")
print(f"云南菜数量: {yunnan_count} 道")
print(f"总菜谱数量: {complete_db['metadata']['total_recipes']} 道")