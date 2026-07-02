#!/usr/bin/env python3
"""
摄影学习技能初始化脚本
"""
import os
import json

def initialize_skill():
    """初始化摄影学习技能"""
    # 创建必要的目录
    directories = [
        "manuals",
        "user_progress",
        "knowledge_base/core_theory",
        "knowledge_base/camera_specific",
        "knowledge_base/practical_scenarios",
        "scripts"
    ]
    
    for directory in directories:
        os.makedirs(f"skills/photography-mentor/{directory}", exist_ok=True)
    
    # 初始化用户进度文件
    user_progress_file = "skills/photography-mentor/user_progress/default.json"
    if not os.path.exists(user_progress_file):
        with open(user_progress_file, 'w') as f:
            json.dump({
                "current_lesson": None,
                "completed_lessons": [],
                "camera_model": None,
                "learning_mode": "systematic"
            }, f)
    
    print("✅ 摄影学习技能初始化完成！")
    print("支持的相机型号: Canon EOS 5D Mark III, Canon EOS R5")
    print("使用方法: 发送 '摄影学习开始' 或 'Canon 5D3 拍摄模式详解'")

if __name__ == "__main__":
    initialize_skill()