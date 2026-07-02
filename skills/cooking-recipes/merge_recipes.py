#!/usr/bin/env python3
import json
import os

# 读取各个菜谱文件
with open('chinese_recipes.json', 'r', encoding='utf-8') as f:
    chinese_data = json.load(f)

with open('international_recipes.json', 'r', encoding='utf-8') as f:
    international_data = json.load(f)

# 合并菜谱
all_recipes = []
all_recipes.extend(chinese_data['recipes'])
all_recipes.extend(international_data['recipes'])

# 创建完整的数据库
complete_db = {
    "metadata": {
        "total_recipes": len(all_recipes),
        "cuisines_covered": [
            "川菜", "粤菜", "鲁菜", "苏菜", "浙菜", "闽菜", "湘菜", "徽菜",
            "京菜", "沪菜", "东北菜", "西北菜", "清真菜", "素斋",
            "泰国菜", "越南菜", "新加坡菜", "马来西亚菜", "印度菜",
            "法国菜", "意大利菜", "西班牙菜", "德国菜", "英国菜", "俄罗斯菜",
            "日本料理", "韩国料理", "墨西哥菜", "巴西菜", "阿根廷菜",
            "地中海菜", "中东菜", "希腊菜", "土耳其菜"
        ],
        "last_updated": "2026-03-19",
        "version": "3.0"
    },
    "recipes": all_recipes
}

# 保存完整数据库
with open('complete_recipes_database.json', 'w', encoding='utf-8') as f:
    json.dump(complete_db, f, ensure_ascii=False, indent=2)

print(f"✅ 成功合并 {len(all_recipes)} 个菜谱到完整数据库！")
print(f"📁 文件已保存为: complete_recipes_database.json")