#!/usr/bin/env python3
"""
摄影学习技能 - 知识查询引擎（最终优化版）
支持更灵活的相机型号匹配和完整的2025-2026年新机型
"""

import os
import json
import re
from pathlib import Path

class KnowledgeQuery:
    def __init__(self, skill_path):
        self.skill_path = Path(skill_path)
        self.references_path = self.skill_path / "references"
        self.config_path = self.skill_path / "config"
        
    def query_by_camera_and_topic(self, camera_model, topic=None):
        """根据相机型号和主题查询知识"""
        # 解析相机型号
        brand, model_key = self._parse_camera_model(camera_model)
        
        if not brand or not model_key:
            return f"不支持的相机型号: {camera_model}\n\n支持的相机品牌包括: Canon, Sony, Nikon, Panasonic, Leica, Sigma\n可使用完整型号名称或简写形式查询。"
        
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
                    brand_name = brand.capitalize()
                    if brand == "leica":
                        brand_name = "Leica"
                    elif brand == "sigma":
                        brand_name = "Sigma"
                    content_parts.append(f"## {brand_name.upper()} 通用操作\n\n{content}")
        
        # 3. 查找具体型号差异
        model_specific_file = self.references_path / f"{brand}_{model_key}.md"
        if model_specific_file.exists():
            found_any = True
            with open(model_specific_file, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    # 从配置中获取显示名称
                    config = self._load_camera_config()
                    display_name = config["supported_models"][brand][model_key]["display_name"]
                    content_parts.append(f"## {display_name} 差异化特性\n\n{content}")
        
        if not found_any:
            return f"找到了相机型号 {camera_model}，但缺少详细的操作指南文档。\n请稍后更新相关参考资料。"
        
        return "\n\n".join(content_parts)
    
    def _normalize_input(self, text):
        """标准化输入文本，处理各种格式变体"""
        if not text:
            return ""
        
        text = text.lower().strip()
        
        # 处理常见的缩写和变体
        replacements = {
            'mark ii': 'ii',
            'mark iii': 'iii', 
            'mark iv': 'iv',
            'alpha': '',
            'eos': '',
            'lumix': '',
            'fp mark ii': 'fp_ii',
            'a7c iii': 'a7c_iii',
            'a7s iv': 'a7s_iv',
            'z9 mark ii': 'z9_ii',
            's5 iii': 's5_iii',
            's1 mark ii': 's1_ii',
            ' ': '_',
            '-': '_',
            '.': '',
            '(': '',
            ')': ''
        }
        
        for old, new in replacements.items():
            text = text.replace(old, new)
            
        # 移除多余的下划线
        text = re.sub(r'_+', '_', text)
        text = re.sub(r'^_|_$', '', text)
        
        return text
    
    def _parse_camera_model(self, camera_model):
        """解析相机型号为品牌和具体型号键"""
        camera_config = self._load_camera_config()
        supported_models = camera_config.get("supported_models", {})
        
        # 标准化输入
        normalized_input = self._normalize_input(camera_model)
        
        # 创建所有可能的匹配候选
        candidates = []
        
        # 添加原始输入的各种变体
        input_variants = [
            normalized_input,
            normalized_input.replace('_', ''),
            re.sub(r'[0-9]+', '', normalized_input),  # 移除数字版本
        ]
        
        # 遍历所有支持的型号寻找匹配
        for brand, models in supported_models.items():
            for model_key, model_info in models.items():
                display_name = model_info.get("display_name", "")
                normalized_display = self._normalize_input(display_name)
                
                # 检查各种匹配条件
                match_conditions = [
                    normalized_input == model_key,  # 直接匹配键
                    normalized_input in normalized_display,  # 输入在显示名中
                    normalized_display in normalized_input,  # 显示名在输入中
                    any(variant == model_key for variant in input_variants),  # 变体匹配键
                    any(variant in normalized_display for variant in input_variants),  # 变体在显示名中
                ]
                
                if any(match_conditions):
                    candidates.append((brand, model_key, display_name))
        
        # 如果找到多个候选，选择最匹配的
        if candidates:
            # 优先选择完全匹配的
            for brand, model_key, display_name in candidates:
                if normalized_input == self._normalize_input(display_name):
                    return brand, model_key
            
            # 否则返回第一个候选
            return candidates[0][0], candidates[0][1]
        
        return None, None
    
    def _load_camera_config(self):
        """加载相机配置"""
        config_file = self.config_path / "camera_models.json"
        with open(config_file, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def list_supported_cameras(self):
        """列出支持的相机型号"""
        camera_config = self._load_camera_config()
        return camera_config

# 使用示例和测试
if __name__ == "__main__":
    query_engine = KnowledgeQuery("/home/admin/.openclaw/workspace/skills/photography-mentor")
    
    test_cases = [
        "Canon EOS R5 Mark II",
        "Sony Alpha A7C II", 
        "Nikon Z8",
        "Panasonic S5 III",
        "Leica SL3",
        "Sigma fp Mark II",
        "canon r1",
        "sony a7c iii",
        "nikon z9 mark ii",
        "panasonic s1 mark ii"
    ]
    
    for test_case in test_cases:
        print(f"\n=== 测试: {test_case} ===")
        result = query_engine.query_by_camera_and_topic(test_case)
        if "不支持的相机型号" in result or "缺少详细的操作指南" in result:
            print("❌ " + result.split('\n')[0])
        else:
            print("✅ 找到:")
            # 只显示前200个字符作为预览
            preview = result[:200] + "..." if len(result) > 200 else result
            print(preview)