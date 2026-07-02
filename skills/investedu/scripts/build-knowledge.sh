#!/bin/bash
# build-knowledge.sh - 联网搜索构建投资知识库
# 使用 searxng 搜索各个知识模块的内容

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
SEARXNG_SCRIPT="$SKILL_DIR/../../searxng/scripts/searxng.py"
CURRICULUM_DIR="$SKILL_DIR/curriculum"
REFERENCES_DIR="$SKILL_DIR/references"

mkdir -p "$CURRICULUM_DIR/L1-basics" "$CURRICULUM_DIR/L2-advanced" "$CURRICULUM_DIR/L3-professional" "$CURRICULUM_DIR/L4-expert"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo "╔════════════════════════════════════════════╗"
echo "║     📚 InvestEdu 知识库构建                ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# 搜索函数
search_and_save() {
    local topic="$1"
    local output_file="$2"
    local query="$3"
    
    echo -e "${CYAN}搜索：$topic${NC}"
    
    local results=$(uv run "$SEARXNG_SCRIPT" search "$query" -n 10 --format json 2>/dev/null)
    
    {
        echo "# $topic"
        echo ""
        echo "## 搜索结果"
        echo ""
        echo "$results" | jq -r '.results[:10] | .[] | "### \(.title)\n\n**来源**: \(.url)\n\n\(.content)\n"' 2>/dev/null || echo "(暂无结果)"
        echo ""
        echo "---"
        echo ""
        echo "*生成时间*: $(date '+%Y-%m-%d %H:%M:%S')"
    } > "$output_file"
    
    echo -e "  ${GREEN}✓ 已保存：$output_file${NC}"
}

# L1 基础阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}L1 基础阶段${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_and_save "投资基础概念" "$CURRICULUM_DIR/L1-basics/investment-basics.md" \
    "投资基础概念 什么是投资 投资 vs 投机 资产类别 2026"

search_and_save "风险与收益" "$CURRICULUM_DIR/L1-basics/risk-return.md" \
    "投资风险与收益 风险类型 风险收益权衡 2026"

search_and_save "复利与时间价值" "$CURRICULUM_DIR/L1-basics/compound-interest.md" \
    "复利 时间价值 72 法则 投资复利计算 2026"

search_and_save "通货膨胀" "$CURRICULUM_DIR/L1-basics/inflation.md" \
    "通货膨胀 通胀影响 实际收益率 CPI 2026"

search_and_save "股票市场基础" "$CURRICULUM_DIR/L1-basics/stock-market.md" \
    "股票市场基础 交易所 IPO 二级市场 A 股港股美股 2026"

search_and_save "基金类型" "$CURRICULUM_DIR/L1-basics/fund-types.md" \
    "基金类型 公募基金 ETF 指数基金 主动基金 2026"

# L2 进阶阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}L2 进阶阶段${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_and_save "GDP 与经济增长" "$CURRICULUM_DIR/L2-advanced/gdp-growth.md" \
    "GDP 国内生产总值 经济增长 经济数据解读 2026"

search_and_save "利率与货币政策" "$CURRICULUM_DIR/L2-advanced/interest-rate-policy.md" \
    "利率 货币政策 央行 美联储 降准降息 2026"

search_and_save "经济周期" "$CURRICULUM_DIR/L2-advanced/economic-cycle.md" \
    "经济周期 复苏繁荣衰退萧条 美林时钟 2026"

search_and_save "波特五力模型" "$CURRICULUM_DIR/L2-advanced/porter-five-forces.md" \
    "波特五力模型 行业分析框架 竞争分析 2026"

search_and_save "财务报表基础" "$CURRICULUM_DIR/L2-advanced/financial-statements.md" \
    "财务报表基础 资产负债表 利润表 现金流量表 2026"

search_and_save "财务比率分析" "$CURRICULUM_DIR/L2-advanced/financial-ratios.md" \
    "财务比率分析 ROE 毛利率 净利率 杜邦分析 2026"

search_and_save "PE 估值法" "$CURRICULUM_DIR/L2-advanced/pe-valuation.md" \
    "PE 市盈率 估值方法 PEG 相对估值 2026"

search_and_save "DCF 估值基础" "$CURRICULUM_DIR/L2-advanced/dcf-basics.md" \
    "DCF 现金流折现 估值模型 自由现金流 2026"

# L3 专业阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}L3 专业阶段${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_and_save "DCF 详细建模" "$CURRICULUM_DIR/L3-professional/dcf-modeling.md" \
    "DCF 详细建模 WACC 终值计算 敏感性分析 2026"

search_and_save "期权定价" "$CURRICULUM_DIR/L3-professional/options-pricing.md" \
    "期权定价 Black-Scholes 模型 希腊字母 Delta Gamma 2026"

search_and_save "因子模型" "$CURRICULUM_DIR/L3-professional/factor-models.md" \
    "因子模型 Fama-French 三因子 量化投资 2026"

search_and_save "现代投资组合理论" "$CURRICULUM_DIR/L3-professional/modern-portfolio.md" \
    "现代投资组合理论 MPT 有效前沿 资产配置 2026"

# 完成
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}✅ 知识库构建完成！${NC}"
echo ""
echo "📁 知识文件位置:"
find "$CURRICULUM_DIR" -name "*.md" | sort | while read -r file; do
    echo "  • $file"
done
echo ""
echo "💡 使用方法:"
echo "  • 查看知识：cat curriculum/L1-basics/*.md"
echo "  • 搜索知识：grep -r \"关键词\" curriculum/"
echo ""
