#!/usr/bin/env python3
"""
摄影学习技能 - 课程生成器
根据用户的学习进度和需求生成个性化课程内容
"""

import os
import json
from pathlib import Path

class LessonGenerator:
    def __init__(self, skill_path):
        self.skill_path = Path(skill_path)
        self.knowledge_base = self.skill_path / "knowledge_base"
        self.config_path = self.skill_path / "config"
        
    def generate_systematic_lesson(self, user_camera=None, current_topic=None):
        """生成系统性学习课程"""
        learning_paths = self._load_learning_paths()
        
        if current_topic is None:
            # 从头开始
            current_topic = "exposure_triangle"
            
        # 获取当前主题内容
        lesson_content = self._get_topic_content(current_topic, user_camera)
        
        # 获取下一个主题
        next_topic = self._get_next_topic(learning_paths, current_topic)
        
        return {
            "current_topic": current_topic,
            "content": lesson_content,
            "next_topic": next_topic,
            "progress": self._calculate_progress(learning_paths, current_topic)
        }
    
    def generate_deep_dive_lesson(self, topic, user_camera=None):
        """生成深度学习课程"""
        content = self._get_topic_content(topic, user_camera)
        related_topics = self._get_related_topics(topic)
        
        return {
            "topic": topic,
            "content": content,
            "related_topics": related_topics
        }
    
    def _load_learning_paths(self):
        """加载学习路径配置"""
        config_file = self.config_path / "learning_paths.json"
        with open(config_file, 'r', encoding='utf-8') as f:
            return json.load(f)
    
    def _get_topic_content(self, topic, user_camera=None):
        """获取主题内容，结合相机型号定制"""
        content = ""
        
        # 首先尝试核心理论
        core_file = self.knowledge_base / "core_theory" / f"{topic}.md"
        if core_file.exists():
            with open(core_file, 'r', encoding='utf-8') as f:
                content = f.read()
        
        # 然后尝试实战场景
        if not content:
            scenario_file = self.knowledge_base / "practical_scenarios" / f"{topic}.md"
            if scenario_file.exists():
                with open(scenario_file, 'r', encoding='utf-8') as f:
                    content = f.read()
        
        # 如果有相机型号，添加特定操作指南
        if user_camera and content:
            camera_parts = user_camera.lower().replace("canon", "").replace("eos", "").strip().split()
            model_name = "_".join(camera_parts).replace(" ", "_").replace("-", "_")
            
            # 尝试不同的模型名称格式
            possible_models = [
                model_name,
                f"eos_{model_name}",
                model_name.replace("mark", "mark_"),
                model_name.replace("r5", "eos_r5")
            ]
            
            for model in possible_models:
                camera_file = self.knowledge_base / "camera_specific" / "canon" / model / f"{topic}.md"
                if camera_file.exists():
                    with open(camera_file, 'r', encoding='utf-8') as f:
                        camera_content = f.read()
                    content += f"\n\n## {user_camera} 专属操作指南\n\n{camera_content}"
                    break
        
        return content if content else f"暂未找到 '{topic}' 相关内容。"
    
    def _get_next_topic(self, learning_paths, current_topic):
        """获取下一个学习主题"""
        path = learning_paths.get("beginner_path", {}).get("modules", [])
        try:
            current_index = path.index(current_topic)
            if current_index + 1 < len(path):
                return path[current_index + 1]
        except ValueError:
            pass
        return None
    
    def _calculate_progress(self, learning_paths, current_topic):
        """计算学习进度"""
        path = learning_paths.get("beginner_path", {}).get("modules", [])
        try:
            current_index = path.index(current_topic)
            return (current_index + 1) / len(path) * 100
        except ValueError:
            return 0
    
    def _get_related_topics(self, topic):
        """获取相关主题"""
        topic_map = {
            "exposure_triangle": ["shooting_modes", "low_light"],
            "composition": ["portrait", "landscape"],
            "lighting": ["portrait", "low_light"],
            "color_theory": ["portrait", "landscape"]
        }
        return topic_map.get(topic, [])

# 使用示例
if __name__ == "__main__":
    generator = LessonGenerator("/home/admin/.openclaw/workspace/skills/photography-mentor")
    
    # 系统学习示例
    lesson = generator.generate_systematic_lesson("Canon EOS R5", "exposure_triangle")
    print(f"当前主题: {lesson['current_topic']}")
    print(f"进度: {lesson['progress']:.1f}%")
    print(f"内容预览: {lesson['content'][:200]}...")
    
    # 深度学习示例
    deep_lesson = generator.generate_deep_dive_lesson("portrait", "Canon EOS R5")
    print(f"\n深度学习 - {deep_lesson['topic']}")
    print(f"相关内容: {deep_lesson['related_topics']}")