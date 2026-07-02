#!/usr/bin/env python3
"""
摄影学习技能 - 知识查询引擎（扁平化references结构）
改进版：支持2025-2026年新机型和更灵活的型号解析
"""

import os
import json
from pathlib import Path
import re

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
            available_models = self._get_available_models()
            return f"未找到 '{camera_model}' 的相关内容。\n\n支持的相机型号包括:\n{available_models}"
        
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
                    brand_name = brand.upper()
                    content_parts.append(f"## {brand_name} 通用操作\n\n{content}")
        
        # 3. 查找具体型号差异
        model_specific_file = self.references_path / f"{brand}_{model_key}.md"
        if model_specific_file.exists():
            found_any = True
            with open(model_specific_file, 'r', encoding='utf-8') as f:
                content = f.read().strip()
                if content:
                    display_name = self._get_display_name(brand, model_key)
                    content_parts.append(f"## {display_name} 差异化特性\n\n{content}")
        
        if not found_any:
            available_models = self._get_available_models()
            return f"找到了相机型号但缺少详细内容。\n\n支持的相机型号包括:\n{available_models}"
        
        return "\n\n".join(content_parts)
    
    def _normalize_input(self, text):
        """标准化输入文本，处理各种格式变体"""
        if not text:
            return ""
        
        # 转换为小写
        text = text.lower()
        
        # 处理罗马数字
        text = text.replace(" mark ii", "_ii").replace(" mark iii", "_iii").replace(" mark iv", "_iv")
        text = text.replace(" ii ", "_ii_").replace(" iii ", "_iii_").replace(" iv ", "_iv_")
        text = text.replace(" ii", "_ii").replace(" iii", "_iii").replace(" iv", "_iv")
        
        # 处理连字符和空格
        text = text.replace("-", "_").replace(" ", "_")
        
        # 移除多余的下划线
        text = re.sub(r'_+', '_', text)
        text = text.strip('_')
        
        return text
    
    def _parse_camera_model(self, camera_model):
        """解析相机型号为品牌和具体型号键"""
        camera_config = self._load_camera_config()
        supported_models = camera_config.get("supported_models", {})
        
        # 标准化输入
        normalized_input = self._normalize_input(camera_model)
        
        # 创建所有可能的匹配字符串
        input_variants = [
            normalized_input,
            normalized_input.replace("alpha_", "").replace("eos_", "").replace("lumix_", ""),
            normalized_input.replace("sony_", "").replace("canon_", "").replace("nikon_", "").replace("panasonic_", "").replace("leica_", "").replace("sigma_", ""),
        ]
        
        # 遍历所有品牌和型号
        for brand, models in supported_models.items():
            brand_normalized = self._normalize_input(brand)
            
            for model_key, model_info in models.items():
                display_name = model_info.get("display_name", "")
                display_normalized = self._normalize_input(display_name)
                
                # 创建型号键的标准化版本
                model_key_normalized = self._normalize_input(model_key)
                
                # 检查所有可能的匹配
                all_variants = [
                    display_normalized,
                    model_key_normalized,
                    f"{brand_normalized}_{model_key_normalized}",
                    f"{brand_normalized}{model_key_normalized}",
                ]
                
                # 添加品牌前缀变体
                if not display_normalized.startswith(brand_normalized):
                    all_variants.append(f"{brand_normalized}_{display_normalized}")
                
                # 检查是否匹配
                for variant in all_variants:
                    for input_var in input_variants:
                        if (input_var == variant or 
                            input_var in variant or 
                            variant in input_var or
                            self._fuzzy_match(input_var, variant)):
                            return brand, model_key
        
        return None, None
    
    def _fuzzy_match(self, str1, str2):
        """模糊匹配，处理拼写错误和简写"""
        if not str1 or not str2:
            return False
            
        # 计算相似度（简单实现）
        min_len = min(len(str1), len(str2))
        if min_len == 0:
            return False
            
        # 检查共同子串长度
        common_chars = sum(1 for c1, c2 in zip(str1, str2) if c1 == c2)
        similarity = common_chars / min_len
        
        return similarity >= 0.7
    
    def _get_display_name(self, brand, model_key):
        """获取显示名称"""
        camera_config = self._load_camera_config()
        supported_models = camera_config.get("supported_models", {})
        if brand in supported_models and model_key in supported_models[brand]:
            return supported_models[brand][model_key].get("display_name", f"{brand} {model_key}")
        return f"{brand} {model_key}"
    
    def _get_available_models(self):
        """获取可用相机型号列表（按品牌分组）"""
        camera_config = self._load_camera_config()
        supported_models = camera_config.get("supported_models", {})
        
        result_lines = []
        for brand, models in supported_models.items():
            brand_line = f"- **{brand.upper()}**: "
            model_names = [info.get("display_name", key) for key, info in models.items()]
            brand_line += ", ".join(model_names[:3])  # 只显示前3个
            if len(model_names) > 3:
                brand_line += f" (等{len(model_names)}款)"
            result_lines.append(brand_line)
        
        return "\n".join(result_lines)
    
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
        "nikon z9 mark ii",
        "panasonic s1 mark ii"
    ]
    
    for test_case in test_cases:
        print(f"\n=== 测试: {test_case} ===")
        result = query_engine.query_by_camera_and_topic(test_case)
        if "未找到" in result or "缺少详细内容" in result:
            print("❌ 未找到")
        else:
            print("✅ 找到:")
            # 只显示前200字符作为预览
            preview = result[:200] + "..." if len(result) > 200 else result
            print(preview)