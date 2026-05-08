# 有趣的skill

闲暇时搞的几个有趣的 skill，目前包含三个模块：

## 📷 photography-mentor | 摄影导师

全面的摄影教学与相机操作指南，覆盖 12+ 主流相机品牌。

**支持品牌**：Canon、Sony、Nikon、Fujifilm、Panasonic、OM System、Leica、Hasselblad、Pentax、Ricoh、GoPro、DJI、Insta360

**功能**：
- 双路径学习：入门路径（曝光三角、构图、用光）和进阶路径（高级曝光、景深控制、创意构图）
- 基于继承架构的知识库，按品牌通用 → 具体型号逐层细化
- 支持上传相机说明书（PDF/DOC）自动解析生成知识卡片
- 中英双语摄影理论参考

---

## 目录结构

```
skills/
├── cooking-recipes/       # 烹饪菜谱助手
│   ├── SKILL.md
│   ├── config.json
│   ├── cooking_skill.py
│   ├── search_recipes.py
│   └── *.json             # 菜谱数据库
└── photography-mentor/    # 摄影导师
    ├── SKILL.md
    ├── USAGE_GUIDE.md
    ├── config/            # 相机型号配置、学习路径
    ├── scripts/           # 知识查询、课程生成、说明书解析
    └── references/        # 摄影理论、品牌参考、场景指南
```
