---
name: investedu
description: 投资知识教育技能。提供系统化投资学习体系 (L1-L4)、学习路径规划、知识问答、水平评估、进度跟踪。涵盖股票、债券、基金、估值、宏观、行业分析等。适用于投资知识学习和能力提升。触发词：投资学习、学习路径、估值方法、财务分析、知识问答等。
metadata:
  {
    "openclaw":
      {
        "emoji": "📚",
        "requires": { "bins": ["bash", "jq"] },
        "triggers":
          [
            "投资学习",
            "学习路径",
            "如何学习投资",
            "估值方法",
            "财务分析",
            "投资知识",
            "CFA",
            "投资入门",
            "股票学习",
          ],
      },
  }
---

# InvestEdu - 投资知识教育技能

标准化投资学习技能，提供从入门到专业的完整知识体系。

## 标准化接口

### 核心命令

所有脚本位于 `{baseDir}/scripts/` 目录：

| 命令 | 功能 | 参数 | 示例 |
|------|------|------|------|
| `show-framework.sh` | 展示知识体系 | 无 | `./show-framework.sh` |
| `assess-level.sh` | 水平评估测试 | 无 | `./assess-level.sh` |
| `plan-learning.sh` | 学习路径规划 | 学习目标 | `./plan-learning.sh "估值分析"` |
| `knowledge-qa.sh` | 知识问答 | 问题 | `./knowledge-qa.sh "PE 估值"` |
| `quiz.sh` | 知识测试 | 主题 | `./quiz.sh stock` |
| `progress.sh` | 进度跟踪 | --complete | `./progress.sh --complete "模块名"` |
| `build-knowledge.sh` | 知识构建 | 无 | `./build-knowledge-full.sh` |

### 知识库路径

- **课程库**: `{baseDir}/curriculum/`
  - `L1-basics/` - 基础阶段 (6 模块)
  - `L2-advanced/` - 进阶阶段 (9 模块)
  - `L3-professional/` - 专业阶段 (6 模块)
  - `L4-expert/` - 专家阶段 (9 模块)
- **参考文档**: `{baseDir}/references/`
- **用户配置**: `{baseDir}/config/user-profile.json`
- **学习记录**: `{baseDir}/progress/`

## 使用方式

### 方式 1: 直接调用脚本

```bash
cd {baseDir}/scripts

# 查看知识体系
./show-framework.sh

# 评估水平
./assess-level.sh

# 规划学习
./plan-learning.sh "股票投资"

# 知识问答
./knowledge-qa.sh "什么是 DCF"

# 知识测试
./quiz.sh valuation
```

### 方式 2: 通过 AI 助手

告诉 AI 你的学习需求，AI 会调用相应功能：

```
用户：我想学习估值分析
AI: [调用 plan-learning.sh "估值分析"]
AI: 生成 8 周学习计划...

用户：考考我关于 PE 估值的知识
AI: [调用 quiz.sh valuation]
AI: 开始测试...
```

### 方式 3: 查阅知识库

```bash
# 查看特定模块
cat {baseDir}/curriculum/L2-advanced/07-pe-valuation.md

# 搜索知识
grep -ri "ROE" {baseDir}/curriculum/

# 查看索引
cat {baseDir}/references/knowledge-index.md
```

## 知识体系

### L1 基础阶段 (0-3 个月)
- 投资基础概念
- 风险与收益
- 复利与时间价值
- 通货膨胀
- 股票市场基础
- 基金投资基础

### L2 进阶阶段 (3-12 个月)
- GDP 与经济增长
- 利率与货币政策
- 经济周期
- 波特五力模型
- 财务报表基础
- 财务比率分析
- PE 估值法
- PB 与 PS 估值
- DCF 估值基础

### L3 专业阶段 (1-3 年)
- DCF 详细建模
- 期权基础与定价
- 期货与衍生品
- 因子模型
- 现代投资组合理论
- 资产配置策略

### L4 专家阶段 (3 年+)
- 固定收益投资
- 另类投资 (PE/VC/对冲基金)
- 行为金融与心理
- 2026 投资策略
- 投资伦理与合规
- 投资大师理论
- 投资组合管理实战
- 投资实战案例

## 标准化输出格式

### 学习规划输出

```
╔════════════════════════════════════════════╗
║     📚 InvestEdu 学习路径规划              ║
╚════════════════════════════════════════════╝

📅 生成时间：YYYY-MM-DD HH:MM:SS
🎯 学习目标：{topic}
📊 当前水平：{level}
⏱️  预计周期：{weeks} 周

━━━ 学习计划详情 ━━━

第 1-2 周：{module}
📌 学习内容:
  • ...
📚 推荐资源:
  • ...
✅ 实践任务:
  • ...
```

### 知识问答输出

```
╔════════════════════════════════════════════╗
║     💡 InvestEdu 知识问答                  ║
╚════════════════════════════════════════════╝

📅 时间：YYYY-MM-DD HH:MM:SS
❓ 问题：{question}

📚 本地知识库搜索结果:
  📄 {module_name}
     {content_snippet}

🌐 联网搜索结果:
  📰 {title}
     🔗 {url}

📝 知识摘要:
{summary}
```

### 水平评估输出

```
╔════════════════════════════════════════════╗
║     📝 InvestEdu 水平评估测试              ║
╚════════════════════════════════════════════╝

📊 测试结果
  得分：{score} / {total} ({percentage}%)
  评估等级：{level}

📌 学习建议:
  {recommendation}
```

## 配置说明

### 用户档案 ({baseDir}/config/user-profile.json)

```json
{
  "name": "投资者",
  "currentLevel": "新手",
  "assessmentDate": "2026-03-05",
  "goals": ["股票投资", "估值分析"],
  "timePerWeek": 10,
  "startDate": "2026-03-05",
  "completedModules": [],
  "notes": ""
}
```

### 环境变量 (可选)

```bash
# 自定义 SearXNG 实例 (用于联网搜索)
export SEARXNG_URL="http://localhost:8080"
```

## 依赖说明

### 必需依赖
- `bash` - 脚本执行
- `jq` - JSON 处理

### 可选依赖
- `python3` - 用于 searxng 脚本调用
- `searxng` - 用于联网搜索（技能自动调用 searxng 技能）

### 安装检查

```bash
# 检查依赖
which bash && which jq

# 安装缺失依赖 (Debian/Ubuntu)
sudo apt-get install jq

# 安装缺失依赖 (macOS)
brew install jq
```

## 文件结构标准

```
investedu/
├── SKILL.md                    # 技能定义 (本文件)
├── README.md                   # 使用说明
├── scripts/                    # 可执行脚本
│   ├── show-framework.sh       # 展示框架
│   ├── assess-level.sh         # 水平评估
│   ├── plan-learning.sh        # 学习规划
│   ├── knowledge-qa.sh         # 知识问答
│   ├── quiz.sh                 # 知识测试
│   ├── progress.sh             # 进度跟踪
│   └── build-knowledge-full.sh # 知识构建
├── curriculum/                 # 课程知识库
│   ├── L1-basics/              # L1 课程 (6 模块)
│   ├── L2-advanced/            # L2 课程 (9 模块)
│   ├── L3-professional/        # L3 课程 (6 模块)
│   └── L4-expert/              # L4 课程 (9 模块)
├── references/                 # 参考文档
│   ├── knowledge-framework.md  # 知识框架
│   ├── book-list.md            # 推荐书单
│   ├── knowledge-validation.md # 验证报告
│   └── knowledge-index.md      # 知识索引
├── config/                     # 配置文件
│   └── user-profile.json       # 用户档案
├── progress/                   # 学习记录
└── logs/                       # 日志目录
```

## 兼容性说明

### 平台兼容
- ✅ Linux (Debian/Ubuntu/CentOS)
- ✅ macOS
- ✅ WSL (Windows Subsystem for Linux)

### OpenClaw 版本
- 兼容 OpenClaw v1.0+
- 使用标准技能格式
- 遵循 OpenClaw 技能规范

### 路径处理
- 使用 `{baseDir}` 占位符
- 自动解析为技能实际路径
- 支持绝对路径和相对路径

## 扩展接口

### 添加新课程模块

1. 在对应阶段目录创建文件：
```bash
cat > {baseDir}/curriculum/L2-advanced/10-new-topic.md << 'EOF'
# 新课程主题

**更新时间**: YYYY-MM-DD

---

## 核心概念
...
EOF
```

2. 更新知识索引：
```bash
./build-knowledge-full.sh
```

### 添加新测试题目

编辑 `scripts/quiz.sh`，在对应题库数组中添加：

```bash
declare -A QUIZ_NEW_TOPIC=(
    ["问题？|A.选项 1|B.选项 2|C.选项 3|A|解析"]
)
```

### 自定义学习路径

编辑 `scripts/plan-learning.sh`，添加新的主题映射：

```bash
TOPIC_MAPPING["新主题"]="new-curriculum-key"
```

## 测试与验证

### 功能测试

```bash
# 测试所有脚本可执行
cd {baseDir}/scripts
for script in *.sh; do
    bash -n "$script" && echo "✅ $script 语法正确"
done

# 测试知识问答
./knowledge-qa.sh "PE 估值"

# 测试学习规划
./plan-learning.sh "股票投资"

# 测试知识测试
./quiz.sh stock
```

### 知识库验证

```bash
# 检查文件完整性
find {baseDir}/curriculum -name "*.md" | wc -l
# 应输出：50+

# 检查索引完整性
cat {baseDir}/references/knowledge-index.md

# 运行验证报告
cat {baseDir}/references/knowledge-validation.md
```

## 版本信息

| 版本 | 日期 | 更新内容 |
|------|------|----------|
| v1.0 | 2026-03-05 | 初始版本，完整 L1-L4 知识体系 |

## 维护说明

### 定期更新
- **季度**: 更新投资策略展望
- **半年**: 审查知识内容准确性
- **年度**: 全面更新知识体系

### 问题反馈
如发现知识错误或改进建议，记录于：
`{baseDir}/logs/feedback.md`

## 免责声明

⚠️ **教育用途声明**

- 本技能仅提供投资知识教育
- 不构成任何投资建议或推荐
- 不保证投资收益或避免损失
- 学习投资知识需要时间和实践
- 投资有风险，入市需谨慎
- 重大投资决策请咨询持牌专业人士

---

*InvestEdu v1.0 - 标准化投资知识教育技能*
