#!/bin/bash
# show-framework.sh - 展示投资知识体系框架

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
REFERENCES_DIR="$SKILL_DIR/references"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

# 主函数
main() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     📚 InvestEdu 投资知识体系              ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "📅 更新时间：$timestamp"
    echo ""
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📊 知识体系总览${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo "┌─────────────────────────────────────────────────────┐"
    echo "│              投资知识体系                            │"
    echo "│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │"
    echo "│  │ L1 基础  │→│ L2 进阶  │→│ L3 专业  │→│ L4 专家  │   │"
    echo "│  │ 0-3 月   │ │ 3-12 月  │ │  1-3 年  │ │  3 年 +   │   │"
    echo "│  └─────────┘ └─────────┘ └─────────┘ └─────────┘   │"
    echo "└─────────────────────────────────────────────────────┘"
    echo ""
    
    # L1 基础阶段
    echo -e "${GREEN}━━━ L1 基础阶段 (0-3 个月) ━━━${NC}"
    echo ""
    echo "📌 模块 1.1: 投资基础概念"
    echo "   • 什么是投资 | 资产类别 | 风险与收益 | 复利 | 通胀"
    echo ""
    echo "📌 模块 1.2: 金融市场概览"
    echo "   • 股票市场 | 债券市场 | 基金 | 衍生品 | 外汇 | 大宗商品"
    echo ""
    echo "📌 模块 1.3: 投资工具与操作"
    echo "   • 证券账户 | 交易软件 | 订单类型 | 交易费用"
    echo ""
    
    # L2 进阶阶段
    echo -e "${CYAN}━━━ L2 进阶阶段 (3-12 个月) ━━━${NC}"
    echo ""
    echo "📌 模块 2.1: 宏观经济分析"
    echo "   • GDP | 通胀 | 利率与货币 | 财政政策 | 经济周期"
    echo ""
    echo "📌 模块 2.2: 行业分析框架"
    echo "   • 行业分类 | 生命周期 | 波特五力 | 竞争格局 | 政策"
    echo ""
    echo "📌 模块 2.3: 财务报表分析"
    echo "   • 资产负债表 | 利润表 | 现金流量表 | 财务比率"
    echo ""
    echo "📌 模块 2.4: 估值基础"
    echo "   • PE/PB/PS | DCF 基础 | 股息模型 | 相对估值"
    echo ""
    
    # L3 专业阶段
    echo -e "${PURPLE}━━━ L3 专业阶段 (1-3 年) ━━━${NC}"
    echo ""
    echo "📌 模块 3.1: 深入估值建模"
    echo "   • DCF 建模 | WACC | 终值 | 敏感性分析 | 实物期权"
    echo ""
    echo "📌 模块 3.2: 衍生品定价与策略"
    echo "   • 期货定价 | 期权定价 | 希腊字母 | 对冲策略"
    echo ""
    echo "📌 模块 3.3: 量化投资基础"
    echo "   • 统计基础 | 时间序列 | 因子模型 | 回测方法"
    echo ""
    echo "📌 模块 3.4: 投资组合管理"
    echo "   • 现代组合理论 | 资产配置 | 风险管理 | 业绩评估"
    echo ""
    
    # L4 专家阶段
    echo -e "${RED}━━━ L4 专家阶段 (3 年+) ━━━${NC}"
    echo ""
    echo "📌 模块 4.1: 专题深度研究"
    echo "   • 行业专家 | 策略专家 | 市场专家 | 产品专家"
    echo ""
    echo "📌 模块 4.2: 投资框架构建"
    echo "   • 投资哲学 | 决策流程 | 能力圈 | 持续学习"
    echo ""
    echo "📌 模块 4.3: 实战应用"
    echo "   • 模拟组合 | 实盘操作 | 投资记录 | 定期复盘"
    echo ""
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📖 推荐学习路径${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "🎯 价值投资方向:"
    echo "   L1 → L2 财报 → L2 估值 → L3 深入估值 → L4 实战"
    echo ""
    echo "🎯 宏观策略方向:"
    echo "   L1 → L2 宏观 → L3 资产配置 → L4 实战"
    echo ""
    echo "🎯 量化投资方向:"
    echo "   L1 → L2 统计 → L3 量化模型 → L3 回测 → L4 实战"
    echo ""
    echo "🎯 行业研究方向:"
    echo "   L1 → L2 行业 → L2 财报 → L3 深度研究 → L4 专家"
    echo ""
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "💡 使用提示:"
    echo "  • 查看课程详情：show-curriculum.sh <课程 ID>"
    echo "  • 评估当前水平：assess-level.sh"
    echo "  • 规划学习路径：plan-learning.sh \"我想学习...\""
    echo "  • 查看推荐书单：cat references/book-list.md"
    echo ""
}

# 执行
main "$@"
