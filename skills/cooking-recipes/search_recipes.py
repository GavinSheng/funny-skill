#!/usr/bin/env python3
import requests
import json
import sys

# 配置 SearXNG 实例 URL
SEARXNG_URL = "http://localhost:8080"

def search_recipes(query, categories=None, num_results=10):
    """搜索菜谱"""
    params = {
        'q': query,
        'format': 'json',
        'pageno': 1,
        'safesearch': 0,
        'language': 'zh-CN'
    }
    
    if categories:
        params['categories'] = categories
    
    try:
        response = requests.get(f"{SEARXNG_URL}/search", params=params, timeout=30)
        if response.status_code == 200:
            return response.json()
        else:
            print(f"搜索失败: {response.status_code}")
            return None
    except Exception as e:
        print(f"搜索错误: {e}")
        return None

def main():
    if len(sys.argv) < 2:
        print("用法: python3 search_recipes.py <搜索关键词>")
        return
    
    query = sys.argv[1]
    results = search_recipes(query)
    
    if results and 'results' in results:
        print(f"找到 {len(results['results'])} 个结果:")
        for i, result in enumerate(results['results'][:5]):
            print(f"\n{i+1}. {result.get('title', '无标题')}")
            print(f"   URL: {result.get('url', '无URL')}")
            print(f"   内容摘要: {result.get('content', '无内容')[:100]}...")
    else:
        print("未找到结果")

if __name__ == "__main__":
    main()