#!/usr/bin/env python3
"""
摄影学习技能 - 知识查询引擎 v2（改进版）
支持更灵活的相机型号匹配和更好的错误处理
"""

import os
import json
import re
from pathlib import Path

class KnowledgeQueryV2:
    def __init__(self, skill_path):
        self.skill_path = Path(skill_path)
        self.references_path = self.skill_path / "references"
        self.config_path = self.skill_path / "config"
        self.camera_config = self._load_camera_config()
        
    def query_by_camera_and_topic(self, camera_model, topic=None):
        """根据相机型号和主题查询知识"""
        # 解析相机型号
        brand, model_key = self._parse_camera_model(camera_model)
        
        if not brand or not model_key:
            available_models = self._get_available_models_list()
            return f"未找到匹配的相机型号: {camera_model}\n\n可用的相机型号包括:\n{available_models}"
        
        # 构建搜索路径
        content_parts = []
        found_any = False
        
        # 1. 查找核心理论（如果指定了topic）
        if topic:
            core_file = self.references_path / f"{topic}.md"
            if core_file.exists():
                found_any = True
                with open(core_file, 'r', encoding='utf-8') as f:
                    content = f.read().strip()
                    if content:
                        content_parts.append(content)
        
        # 2. 查找品牌通用操作
        brand_common_file = self.references_path / f"{brand}_common.md"
        if brand_common_file.exists():
            found_any = True
            with open(brand_common_file, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    content_parts.append(f"## {brand.upper()} 通用操作\n\n{content}")
        
        # 3. 查找具体型号差异
        model_specific_file = self.references_path / f"{brand}_{model_key}.md"
        if model_specific_file.exists():
            found_any = True
            with open(model_specific_file, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    display_name = self.camera_config["supported_models"][brand][model_key]["display_name"]
                    content_parts.append(f"## {display_name} 差异化特性\n\n{content}")
        
        if not found_any:
            available_files = [f.stem for f in self.references_path.glob("*.md")]
            return f"未找到 {camera_model} 的相关内容。可用参考文件: {available_files}"
        
        return "\n\n".join(content_parts)
    
    def _parse_camera_model(self, camera_model):
        """解析相机型号为品牌和具体型号键"""
        supported_models = self.camera_config.get("supported_models", {})
        
        # 标准化输入 - 创建多种变体
        input_clean = self._normalize_input(camera_model)
        
        # 遍历所有支持的品牌和型号
        for brand, models in supported_models.items():
            for model_key, model_info in models.items():
                display_name = model_info.get("display_name", "")
                display_clean = self._normalize_input(display_name)
                
                # 检查是否匹配
                if (input_clean == display_clean or 
                    input_clean in display_clean or 
                    display_clean in input_clean):
                    return brand, model_key
                
                # 也检查型号键本身
                model_key_clean = self._normalize_input(model_key.replace("_", " "))
                if input_clean == model_key_clean:
                    return brand, model_key
        
        return None, None
    
    def _normalize_input(self, text):
        """标准化输入文本用于匹配"""
        if not text:
            return ""
        
        # 转换为小写
        text = text.lower()
        # 移除多余空格
        text = re.sub(r'\s+', ' ', text).strip()
        # 标准化常见变体
        text = text.replace(" mark ", " ").replace("mark ", "").replace(" ii", "2").replace(" iii", "3")
        text = text.replace("-", " ").replace("_", " ")
        return text
    
    def _load_camera_config(self):
        """加载相机配置"""
        config_file = self.config_path / "camera_models.json"
        with open(config_file, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def _get_available_models_list(self):
        """获取可用相机型号列表（格式化显示）"""
        supported_models = self.camera_config.get("supported_models", {})
        result_lines = []
        
        for brand, models in supported_models.items():
            brand_line = f"\n{brand.upper()}:"
            result_lines.append(brand_line)
            for model_key, model_info in models.items():
                display_name = model_info.get("display_name", model_key)
                year = model_info.get("release_year", "?")
                result_lines.append(f"  • {display_name} ({year})")
        
        return "\n".join(result_lines)
    
    def list_supported_cameras(self):
        """列出支持的相机型号"""
        return self.camera_config

# 使用示例和测试
if __name__ == "__main__":
    query_engine = KnowledgeQueryV2("/home/admin/.openclaw/workspace/skills/photography-mentor")
    
    # 测试各种输入格式
    test_cases = [
        "Canon EOS R5 Mark II",
        "Sony Alpha A7C II", 
        "Nikon Z8",
        "Panasonic S5 III",
        "Leica SL3",
        "Sigma fp Mark II",
        "canon r1",
        "sony a7c iii",
        "nikon z9 mark ii"
    ]
    
    for test_case in test_cases:
        print(f"\n=== 测试: {test_case} ===")
        result = query_engine.query_by_camera_and_topic(test_case)
        if "未找到匹配的相机型号" in result:
            print("❌ 未找到")
        else:
            lines = result.split('\n')
            first_few_lines = '\n'.join(lines[:3]) if len(lines) > 3 else result
            print(f"✅ 找到:\n{first_few_lines}")