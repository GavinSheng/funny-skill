#!/bin/bash
# knowledge-qa.sh - 投资知识问答
# 基于知识库搜索回答用户问题

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
SEARXNG_SCRIPT="$SKILL_DIR/../../searxng/scripts/searxng.py"
CURRICULUM_DIR="$SKILL_DIR/curriculum"
REFERENCES_DIR="$SKILL_DIR/references"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 显示帮助
show_help() {
    echo "用法：knowledge-qa.sh <问题>"
    echo ""
    echo "示例:"
    echo "  knowledge-qa.sh \"什么是 PE 估值\""
    echo "  knowledge-qa.sh \"如何分析财务报表\""
    echo "  knowledge-qa.sh \"经济周期有哪些阶段\""
    echo "  knowledge-qa.sh \"复利如何计算\""
    echo ""
    echo "功能:"
    echo "  1. 搜索本地知识库"
    echo "  2. 联网搜索补充知识"
    echo "  3. 整理答案并输出"
    echo ""
}

# 搜索本地知识库
search_local() {
    local query="$1"
    
    echo -e "${CYAN}📚 搜索本地知识库...${NC}"
    echo ""
    
    local results=$(grep -ril "$query" "$CURRICULUM_DIR" 2>/dev/null | head -5)
    
    if [[ -n "$results" ]]; then
        echo -e "${GREEN}找到相关知识模块:${NC}"
        echo ""
        echo "$results" | while read -r file; do
            local name=$(basename "$file" .md | sed 's/^[0-9]*-//')
            local dir=$(basename $(dirname "$file"))
            echo "  📄 $dir/$name"
            
            # 显示相关内容片段
            grep -i "$query" "$file" | head -2 | sed 's/^/     /'
            echo ""
        done
        return 0
    else
        echo -e "${YELLOW}本地知识库未找到相关内容${NC}"
        return 1
    fi
}

# 联网搜索
search_web() {
    local query="$1"
    
    echo -e "${CYAN}🌐 联网搜索补充知识...${NC}"
    echo ""
    
    local results=$(uv run "$SEARXNG_SCRIPT" search "$query" -n 8 --format json 2>/dev/null)
    
    if [[ -n "$results" ]]; then
        echo -e "${GREEN}搜索结果:${NC}"
        echo ""
        
        # 显示前 5 个结果
        echo "$results" | jq -r '.results[:5] | .[] | "📰 \(.title)\n   🔗 \(.url)\n   \(.content)\n"' 2>/dev/null
        
        # 显示相关搜索建议
        local suggestions=$(echo "$results" | jq -r '.suggestions[:3] | join(", ")' 2>/dev/null)
        if [[ -n "$suggestions" ]]; then
            echo ""
            echo -e "${BLUE}💡 相关搜索:${NC} $suggestions"
        fi
        return 0
    else
        echo -e "${YELLOW}联网搜索暂无结果${NC}"
        return 1
    fi
}

# 生成知识摘要
generate_summary() {
    local topic="$1"
    
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}📝 知识摘要：$topic${NC}"
    echo ""
    
    # 根据关键词提供基础解释
    case "$topic" in
        *PE*|*市盈率*|*估值*)
            echo "**PE (市盈率)** = 股价 / 每股收益"
            echo ""
            echo "核心要点:"
            echo "• PE 反映投资者愿意为每元盈利支付的价格"
            echo "• 低 PE 可能被低估，高 PE 可能高估或高成长"
            echo "• 不同行业 PE 水平差异大，需横向比较"
            echo "• 周期股 PE 低时可能是高点，高时可能是低点"
            echo ""
            ;;
        *财务*|*报表*|*ROE*)
            echo "**财务报表分析** 是投资分析的核心技能"
            echo ""
            echo "三大报表:"
            echo "• 资产负债表：公司在某一时点的财务状况"
            echo "• 利润表：公司在一定时期的经营成果"
            echo "• 现金流量表：公司在一定时期的现金流入流出"
            echo ""
            echo "关键指标:"
            echo "• ROE (净资产收益率) = 净利润 / 净资产"
            echo "• 毛利率 = (收入 - 成本) / 收入"
            echo "• 净利率 = 净利润 / 收入"
            echo ""
            ;;
        *经济周期*|*周期*)
            echo "**经济周期** 包括四个阶段:"
            echo ""
            echo "1. 复苏：经济开始好转，投资增加"
            echo "2. 繁荣：经济高速增长，就业充分"
            echo "3. 衰退：经济增长放缓，需求下降"
            echo "4. 萧条：经济负增长，失业增加"
            echo ""
            echo "美林时钟:"
            echo "• 复苏期：股票>债券>现金>商品"
            echo "• 过热期：商品>股票>现金>债券"
            echo "• 滞胀期：现金>商品>债券>股票"
            echo "• 衰退期：债券>现金>股票>商品"
            echo ""
            ;;
        *复利*|*时间价值*)
            echo "**复利** 被称为\"世界第八大奇迹\""
            echo ""
            echo "复利公式：FV = PV × (1 + r)^n"
            echo "• FV: 终值"
            echo "• PV: 现值"
            echo "• r: 利率"
            echo "• n: 期数"
            echo ""
            echo "72 法则：本金翻倍时间 ≈ 72 / 年化收益率"
            echo "• 年化 10%，约 7.2 年翻倍"
            echo "• 年化 15%，约 4.8 年翻倍"
            echo "• 年化 20%，约 3.6 年翻倍"
            echo ""
            ;;
        *)
            echo "关于 \"$topic\" 的详细信息，请查看:"
            echo ""
            echo "📚 本地知识库：curriculum/ 目录"
            echo "🌐 网络资源：见上方搜索结果"
            echo ""
            ;;
    esac
}

# 主函数
main() {
    if [[ $# -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    local query="$1"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     💡 InvestEdu 知识问答                  ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "📅 时间：$timestamp"
    echo "❓ 问题：$query"
    echo ""
    
    # 搜索本地知识库
    search_local "$query" || true
    
    echo ""
    
    # 联网搜索
    search_web "$query" || true
    
    # 生成摘要
    generate_summary "$query"
    
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "💡 深入学习:"
    echo "  • 查看知识索引：cat references/knowledge-index.md"
    echo "  • 学习相关模块：cat curriculum/L2-advanced/07-pe-valuation.md"
    echo "  • 进行知识测试：quiz.sh valuation"
    echo ""
}

# 执行
main "$@"
