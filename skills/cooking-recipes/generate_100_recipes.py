#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
大规模菜谱生成脚本
目标：生成100+个详细菜谱，覆盖全球主要菜系
"""

import json
import random

def generate_comprehensive_recipes():
    """生成100+个详细菜谱"""
    
    # 基础菜谱模板
    base_recipes = {
        "川菜": [
            {"name": "鱼香肉丝", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "夫妻肺片", "difficulty": "中级", "prep_time": 30, "cook_time": 20, "servings": 4},
            {"name": "口水鸡", "difficulty": "初级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "辣子鸡", "difficulty": "中级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "酸菜鱼", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 4},
            {"name": "毛血旺", "difficulty": "高级", "prep_time": 40, "cook_time": 30, "servings": 6},
            {"name": "干煸四季豆", "difficulty": "初级", "prep_time": 15, "cook_time": 10, "servings": 3},
            {"name": "蒜泥白肉", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "樟茶鸭", "difficulty": "高级", "prep_time": 120, "cook_time": 60, "servings": 4},
            {"name": "泡椒凤爪", "difficulty": "初级", "prep_time": 30, "cook_time": 15, "servings": 4}
        ],
        "粤菜": [
            {"name": "蜜汁叉烧", "difficulty": "中级", "prep_time": 30, "cook_time": 45, "servings": 4},
            {"name": "豉汁蒸排骨", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "清蒸鲈鱼", "difficulty": "初级", "prep_time": 15, "cook_time": 12, "servings": 3},
            {"name": "蚝油牛肉", "difficulty": "中级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "瑶柱扒时蔬", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 4},
            {"name": "虾饺", "difficulty": "高级", "prep_time": 60, "cook_time": 10, "servings": 4},
            {"name": "肠粉", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 3},
            {"name": "烧鹅", "difficulty": "高级", "prep_time": 60, "cook_time": 90, "servings": 6},
            {"name": "老火靓汤", "difficulty": "初级", "prep_time": 20, "cook_time": 180, "servings": 6},
            {"name": "姜葱炒蟹", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3}
        ],
        "鲁菜": [
            {"name": "葱烧海参", "difficulty": "高级", "prep_time": 30, "cook_time": 45, "servings": 4},
            {"name": "四喜丸子", "difficulty": "中级", "prep_time": 30, "cook_time": 40, "servings": 4},
            {"name": "德州扒鸡", "difficulty": "高级", "prep_time": 60, "cook_time": 120, "servings": 4},
            {"name": "锅塌豆腐", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "油爆双脆", "difficulty": "高级", "prep_time": 25, "cook_time": 5, "servings": 3},
            {"name": "奶汤蒲菜", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "糟溜鱼片", "difficulty": "中级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "红烧大虾", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "木须肉", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "烩乌鱼蛋", "difficulty": "高级", "prep_time": 30, "cook_time": 20, "servings": 4}
        ],
        "苏菜": [
            {"name": "清炖蟹粉狮子头", "difficulty": "高级", "prep_time": 40, "cook_time": 120, "servings": 4},
            {"name": "响油鳝糊", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "水晶肴肉", "difficulty": "高级", "prep_time": 60, "cook_time": 180, "servings": 6},
            {"name": "金陵盐水鸭", "difficulty": "中级", "prep_time": 30, "cook_time": 60, "servings": 4},
            {"name": "梁溪脆鳝", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "鲃肺汤", "difficulty": "中级", "prep_time": 30, "cook_time": 25, "servings": 4},
            {"name": "黄泥煨鸡", "difficulty": "高级", "prep_time": 40, "cook_time": 90, "servings": 4},
            {"name": "荷叶粉蒸肉", "difficulty": "中级", "prep_time": 30, "cook_time": 60, "servings": 4},
            {"name": "无锡排骨", "difficulty": "初级", "prep_time": 20, "cook_time": 45, "servings": 4},
            {"name": "扬州炒饭", "difficulty": "初级", "prep_time": 20, "cook_time": 10, "servings": 3}
        ],
        "浙菜": [
            {"name": "西湖醋鱼", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "龙井虾仁", "difficulty": "中级", "prep_time": 20, "cook_time": 8, "servings": 3},
            {"name": "宋嫂鱼羹", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 4},
            {"name": "干炸响铃", "difficulty": "中级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "蜜汁火方", "difficulty": "高级", "prep_time": 30, "cook_time": 120, "servings": 4},
            {"name": "叫花鸡", "difficulty": "高级", "prep_time": 60, "cook_time": 180, "servings": 4},
            {"name": "鲞㸆肉", "difficulty": "中级", "prep_time": 25, "cook_time": 60, "servings": 4},
            {"name": "莼菜鲈鱼羹", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "宁波汤圆", "difficulty": "中级", "prep_time": 40, "cook_time": 10, "servings": 4},
            {"name": "绍兴醉鸡", "difficulty": "初级", "prep_time": 30, "cook_time": 20, "servings": 4}
        ],
        "闽菜": [
            {"name": "荔枝肉", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "醉排骨", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 3},
            {"name": "太极明虾", "difficulty": "高级", "prep_time": 30, "cook_time": 15, "servings": 4},
            {"name": "生煎明虾", "difficulty": "中级", "prep_time": 25, "cook_time": 10, "servings": 3},
            {"name": "八宝红鲟饭", "difficulty": "高级", "prep_time": 40, "cook_time": 30, "servings": 4},
            {"name": "鸡汤汆海蚌", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 3},
            {"name": "淡糟香螺片", "difficulty": "高级", "prep_time": 25, "cook_time": 8, "servings": 3},
            {"name": "沙茶面", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "蚵仔煎", "difficulty": "初级", "prep_time": 15, "cook_time": 10, "servings": 2},
            {"name": "福州鱼丸", "difficulty": "中级", "prep_time": 40, "cook_time": 15, "servings": 4}
        ],
        "湘菜": [
            {"name": "腊味合蒸", "difficulty": "中级", "prep_time": 25, "cook_time": 45, "servings": 4},
            {"name": "发丝百叶", "difficulty": "中级", "prep_time": 25, "cook_time": 10, "servings": 3},
            {"name": "红椒酿肉", "difficulty": "中级", "prep_time": 30, "cook_time": 20, "servings": 4},
            {"name": "板栗烧鸡", "difficulty": "初级", "prep_time": 25, "cook_time": 35, "servings": 4},
            {"name": "湘西外婆菜", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "永州血鸭", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "洞庭肥鱼", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "长沙臭豆腐", "difficulty": "初级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "湘潭毛氏红烧肉", "difficulty": "初级", "prep_time": 20, "cook_time": 60, "servings": 4},
            {"name": "常德钵子菜", "difficulty": "初级", "prep_time": 25, "cook_time": 40, "servings": 4}
        ],
        "徽菜": [
            {"name": "火腿炖甲鱼", "difficulty": "高级", "prep_time": 30, "cook_time": 120, "servings": 4},
            {"name": "红烧果子狸", "difficulty": "高级", "prep_time": 30, "cook_time": 90, "servings": 4},
            {"name": "黄山炖鸽", "difficulty": "高级", "prep_time": 30, "cook_time": 90, "servings": 3},
            {"name": "符离集烧鸡", "difficulty": "高级", "prep_time": 40, "cook_time": 120, "servings": 4},
            {"name": "问政山笋", "difficulty": "中级", "prep_time": 25, "cook_time": 30, "servings": 4},
            {"name": "一品锅", "difficulty": "中级", "prep_time": 40, "cook_time": 60, "servings": 6},
            {"name": "方腊鱼", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "李鸿章杂烩", "difficulty": "中级", "prep_time": 30, "cook_time": 25, "servings": 4},
            {"name": "徽州毛豆腐", "difficulty": "初级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "无为板鸭", "difficulty": "高级", "prep_time": 60, "cook_time": 90, "servings": 4}
        ]
    }
    
    # 国际菜系
    international_recipes = {
        "泰国菜": [
            {"name": "泰式咖喱蟹", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "泰式柠檬鱼", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "泰式椰汁鸡汤", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "泰式炒河粉", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "泰式芒果糯米饭", "difficulty": "初级", "prep_time": 30, "cook_time": 20, "servings": 4},
            {"name": "泰式椰汁西米露", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 4},
            {"name": "泰式菠萝饭", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "泰式凉拌海鲜", "difficulty": "初级", "prep_time": 25, "cook_time": 10, "servings": 3},
            {"name": "泰式椰汁炖鸡", "difficulty": "初级", "prep_time": 20, "cook_time": 30, "servings": 4},
            {"name": "泰式香茅烤鸡", "difficulty": "中级", "prep_time": 30, "cook_time": 45, "servings": 4}
        ],
        "法国菜": [
            {"name": "法式焗蜗牛", "difficulty": "高级", "prep_time": 30, "cook_time": 15, "servings": 4},
            {"name": "法式鹅肝", "difficulty": "高级", "prep_time": 20, "cook_time": 10, "servings": 3},
            {"name": "法式洋葱挞", "difficulty": "中级", "prep_time": 40, "cook_time": 30, "servings": 6},
            {"name": "法式奶油蘑菇汤", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "法式焗烤扇贝", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "法式焦糖布丁", "difficulty": "中级", "prep_time": 20, "cook_time": 45, "servings": 4},
            {"name": "法式海鲜拼盘", "difficulty": "高级", "prep_time": 40, "cook_time": 20, "servings": 4},
            {"name": "法式蔬菜炖肉", "difficulty": "中级", "prep_time": 30, "cook_time": 90, "servings": 6},
            {"name": "法式苹果挞", "difficulty": "中级", "prep_time": 40, "cook_time": 35, "servings": 6},
            {"name": "法式马卡龙", "difficulty": "高级", "prep_time": 60, "cook_time": 15, "servings": 20}
        ],
        "意大利菜": [
            {"name": "意大利千层面", "difficulty": "中级", "prep_time": 40, "cook_time": 45, "servings": 6},
            {"name": "意大利海鲜意面", "difficulty": "中级", "prep_time": 25, "cook_time": 20, "servings": 3},
            {"name": "意大利蔬菜汤", "difficulty": "初级", "prep_time": 20, "cook_time": 30, "servings": 4},
            {"name": "意大利烤面包", "difficulty": "初级", "prep_time": 15, "cook_time": 10, "servings": 4},
            {"name": "意大利奶酪球", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 4},
            {"name": "意大利蔬菜炖饭", "difficulty": "中级", "prep_time": 20, "cook_time": 25, "servings": 3},
            {"name": "意大利番茄面包汤", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "意大利杏仁饼干", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 20},
            {"name": "意大利蔬菜披萨", "difficulty": "中级", "prep_time": 30, "cook_time": 20, "servings": 4},
            {"name": "意大利咖啡布丁", "difficulty": "初级", "prep_time": 15, "cook_time": 4, "servings": 4}
        ],
        "日本料理": [
            {"name": "天妇罗", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 3},
            {"name": "照烧鸡排", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 3},
            {"name": "日式咖喱饭", "difficulty": "初级", "prep_time": 20, "cook_time": 30, "servings": 4},
            {"name": "日式炸猪排", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "日式茶碗蒸", "difficulty": "中级", "prep_time": 20, "cook_time": 15, "servings": 4},
            {"name": "日式章鱼小丸子", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 4},
            {"name": "日式大阪烧", "difficulty": "中级", "prep_time": 25, "cook_time": 15, "servings": 3},
            {"name": "日式亲子丼", "difficulty": "初级", "prep_time": 15, "cook_time": 15, "servings": 2},
            {"name": "日式玉子烧", "difficulty": "初级", "prep_time": 15, "cook_time": 10, "servings": 3},
            {"name": "日式抹茶冰淇淋", "difficulty": "初级", "prep_time": 20, "cook_time": 4, "servings": 4}
        ],
        "印度菜": [
            {"name": "印度咖喱鸡", "difficulty": "中级", "prep_time": 25, "cook_time": 40, "servings": 4},
            {"name": "印度烤饼", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 6},
            {"name": "印度香料饭", "difficulty": "中级", "prep_time": 30, "cook_time": 45, "servings": 4},
            {"name": "印度酸奶黄瓜酱", "difficulty": "初级", "prep_time": 15, "cook_time": 5, "servings": 4},
            {"name": "印度蔬菜咖喱", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4},
            {"name": "印度香料奶茶", "difficulty": "初级", "prep_time": 10, "cook_time": 10, "servings": 2},
            {"name": "印度炸三角", "difficulty": "中级", "prep_time": 30, "cook_time": 15, "servings": 6},
            {"name": "印度烤羊肉串", "difficulty": "中级", "prep_time": 30, "cook_time": 20, "servings": 4},
            {"name": "印度甜米布丁", "difficulty": "初级", "prep_time": 20, "cook_time": 30, "servings": 4},
            {"name": "印度香料土豆", "difficulty": "初级", "prep_time": 20, "cook_time": 25, "servings": 4}
        ],
        "墨西哥菜": [
            {"name": "墨西哥玉米卷", "difficulty": "初级", "prep_time": 25, "cook_time": 20, "servings": 4},
            {"name": "墨西哥辣椒炖肉", "difficulty": "中级", "prep_time": 30, "cook_time": 120, "servings": 6},
            {"name": "墨西哥鳄梨酱", "difficulty": "初级", "prep_time": 15, "cook_time": 5, "servings": 4},
            {"name": "墨西哥玉米片", "difficulty": "初级", "prep_time": 20, "cook_time": 15, "servings": 4},
            {"name": "墨西哥鸡肉卷饼", "difficulty": "初级", "prep_time": 25, "cook_time": 20, "servings": 4},
            {"name": "墨西哥玉米汤", "difficulty": "初级", "prep_time": 20, "cook_time": 30, "servings": 4},
            {"name": "墨西哥辣味豆泥", "difficulty": "初级", "prep_time": 15, "cook_time": 25, "servings": 4},
            {"name": "墨西哥玉米蛋糕", "difficulty": "中级", "prep_time": 30, "cook_time": 45, "servings": 6},
            {"name": "墨西哥水果沙拉", "difficulty": "初级", "prep_time": 20, "cook_time": 5, "servings": 4},
            {"name": "墨西哥辣椒酱", "difficulty": "初级", "prep_time": 15, "cook_time": 20, "servings": 4}
        ]
    }
    
    # 合并所有菜谱
    all_recipes = []
    
    # 添加中餐菜谱
    for cuisine, recipes in base_recipes.items():
        for recipe in recipes:
            recipe_data = {
                "name": recipe["name"],
                "cuisine": cuisine,
                "difficulty": recipe["difficulty"],
                "prep_time": recipe["prep_time"],
                "cook_time": recipe["cook_time"],
                "servings": recipe["servings"],
                "ingredients": [],  # 稍后填充
                "steps": [],       # 稍后填充
                "tips": ""         # 稍后填充
            }
            all_recipes.append(recipe_data)
    
    # 添加国际菜谱
    for cuisine, recipes in international_recipes.items():
        for recipe in recipes:
            recipe_data = {
                "name": recipe["name"],
                "cuisine": cuisine,
                "difficulty": recipe["difficulty"],
                "prep_time": recipe["prep_time"],
                "cook_time": recipe["cook_time"],
                "servings": recipe["servings"],
                "ingredients": [],
                "steps": [],
                "tips": ""
            }
            all_recipes.append(recipe_data)
    
    return all_recipes

if __name__ == "__main__":
    recipes = generate_comprehensive_recipes()
    print(f"生成了 {len(recipes)} 个菜谱")
    
    # 保存到文件
    with open('massive_recipes_template.json', 'w', encoding='utf-8') as f:
        json.dump({"recipes": recipes}, f, ensure_ascii=False, indent=2)
    
    print("菜谱模板已保存到 massive_recipes_template.json")