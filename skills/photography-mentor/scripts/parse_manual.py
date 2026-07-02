#!/usr/bin/env python3
"""
说明书解析器 - 用于处理用户上传的相机说明书PDF/DOC文件
功能：
1. 自动检测文件类型
2. 提取文本内容
3. 建立关键词索引
4. 生成结构化知识卡片
"""

import os
import json
import re
from pathlib import Path

class ManualParser:
    def __init__(self, manual_path, camera_model):
        self.manual_path = manual_path
        self.camera_model = camera_model
        self.extracted_content = {}
        
    def detect_file_type(self):
        """检测文件类型"""
        if self.manual_path.lower().endswith('.pdf'):
            return 'pdf'
        elif self.manual_path.lower().endswith(('.doc', '.docx')):
            return 'doc'
        else:
            return 'unknown'
    
    def extract_text_from_pdf(self):
        """从PDF提取文本（简化版本）"""
        # 实际实现会使用PyPDF2或pdfplumber等库
        # 这里提供框架
        try:
            with open(self.manual_path, 'r', encoding='utf-8') as f:
                content = f.read()
            return content
        except:
            return "PDF解析功能需要安装额外依赖"
    
    def extract_text_from_doc(self):
        """从DOC/DOCX提取文本（简化版本）"""
        # 实际实现会使用python-docx等库
        return "DOC解析功能需要安装额外依赖"
    
    def build_keyword_index(self, text_content):
        """建立关键词索引"""
        keywords = {
            'shooting_modes': ['拍摄模式', 'mode', 'P', 'Tv', 'Av', 'M', 'B门'],
            'focus_system': ['对焦', 'AF', '自动对焦', '手动对焦', '焦点'],
            'exposure': ['曝光', '光圈', '快门', 'ISO', '测光', '曝光补偿'],
            'menu_navigation': ['菜单', '设置', '自定义', 'C.Fn'],
            'advanced_features': ['防抖', '连拍', '视频', 'Wi-Fi', 'GPS']
        }
        
        index = {}
        for category, terms in keywords.items():
            found_terms = []
            for term in terms:
                if term in text_content:
                    found_terms.append(term)
            if found_terms:
                index[category] = found_terms
        
        return index
    
    def generate_knowledge_cards(self, keyword_index):
        """生成结构化知识卡片"""
        cards = {}
        for category, terms in keyword_index.items():
            cards[category] = {
                'camera_model': self.camera_model,
                'keywords': terms,
                'summary': f"基于说明书提取的{category}相关信息",
                'source_file': os.path.basename(self.manual_path)
            }
        return cards
    
    def process_manual(self):
        """主处理流程"""
        file_type = self.detect_file_type()
        
        if file_type == 'pdf':
            text_content = self.extract_text_from_pdf()
        elif file_type == 'doc':
            text_content = self.extract_text_from_doc()
        else:
            return {"error": "不支持的文件格式"}
        
        keyword_index = self.build_keyword_index(text_content)
        knowledge_cards = self.generate_knowledge_cards(keyword_index)
        
        # 保存到知识库
        camera_dir = f"knowledge_base/camera_specific/manual_extracted/{self.camera_model}"
        os.makedirs(camera_dir, exist_ok=True)
        
        for category, card in knowledge_cards.items():
            card_path = f"{camera_dir}/{category}.json"
            with open(card_path, 'w', encoding='utf-8') as f:
                json.dump(card, f, ensure_ascii=False, indent=2)
        
        return {
            "status": "success",
            "processed_categories": list(knowledge_cards.keys()),
            "camera_model": self.camera_model
        }

def main():
    """命令行接口"""
    import sys
    if len(sys.argv) != 3:
        print("用法: python parse_manual.py <说明书路径> <相机型号>")
        return
    
    manual_path = sys.argv[1]
    camera_model = sys.argv[2]
    
    parser = ManualParser(manual_path, camera_model)
    result = parser.process_manual()
    print(json.dumps(result, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()