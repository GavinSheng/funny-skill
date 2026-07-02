#!/bin/bash
# build-knowledge-full.sh - 完整构建投资知识库
# 使用 searxng 搜索并整理结构化知识

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
PURPLE='\033[0;35m'
NC='\033[0m'

echo "╔════════════════════════════════════════════╗"
echo "║     📚 InvestEdu 完整知识库构建            ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# 改进的搜索函数
search_topic() {
    local topic="$1"
    local output_file="$2"
    local query="$3"
    
    echo -e "${CYAN}搜索：$topic${NC}"
    
    # 获取搜索结果
    local results=$(uv run "$SEARXNG_SCRIPT" search "$query" -n 8 --format json 2>/dev/null)
    
    # 提取标题和内容
    local titles=$(echo "$results" | jq -r '.results[].title' 2>/dev/null | head -8)
    local urls=$(echo "$results" | jq -r '.results[].url' 2>/dev/null | head -8)
    local contents=$(echo "$results" | jq -r '.results[].content' 2>/dev/null | head -8)
    
    {
        echo "# $topic"
        echo ""
        echo "**更新时间**: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
        echo "---"
        echo ""
        echo "## 核心知识点"
        echo ""
        
        # 整理搜索结果
        local count=0
        while IFS= read -r title && IFS= read -r url && IFS= read -r content; do
            ((count++))
            echo "### $count. $title"
            echo ""
            echo "**来源**: $url"
            echo ""
            echo "$content"
            echo ""
        done < <(echo "$results" | jq -r '.results[] | "\(.title)\n\(.url)\n\(.content)"' 2>/dev/null | head -24)
        
        echo ""
        echo "---"
        echo ""
        echo "## 相关资源"
        echo ""
        echo "$results" | jq -r '.suggestions[]' 2>/dev/null | head -5 | while read -r suggestion; do
            echo "- $suggestion"
        done
        echo ""
        
    } > "$output_file"
    
    echo -e "  ${GREEN}✓ 已保存：$output_file${NC}"
}

# L1 基础阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}L1 基础阶段 (0-3 个月)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_topic "投资基础概念" "$CURRICULUM_DIR/L1-basics/01-investment-basics.md" \
    "投资基础概念 什么是投资 资产类别 股票债券基金 2026"

search_topic "风险与收益" "$CURRICULUM_DIR/L1-basics/02-risk-return.md" \
    "投资风险与收益 风险类型 系统性风险 非系统性风险 2026"

search_topic "复利与时间价值" "$CURRICULUM_DIR/L1-basics/03-compound-interest.md" \
    "复利 时间价值 复利计算 72 法则 长期投资 2026"

search_topic "通货膨胀" "$CURRICULUM_DIR/L1-basics/04-inflation.md" \
    "通货膨胀 CPI 通胀影响 实际收益率 购买力 2026"

search_topic "股票市场基础" "$CURRICULUM_DIR/L1-basics/05-stock-market.md" \
    "股票市场基础 A 股港股美股 交易所 IPO 交易机制 2026"

search_topic "基金投资基础" "$CURRICULUM_DIR/L1-basics/06-fund-basics.md" \
    "基金投资基础 公募基金 ETF 指数基金 主动基金 2026"

# L2 进阶阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}L2 进阶阶段 (3-12 个月)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_topic "GDP 与经济增长" "$CURRICULUM_DIR/L2-advanced/01-gdp-growth.md" \
    "GDP 国内生产总值 经济增长 经济数据解读 2026"

search_topic "利率与货币政策" "$CURRICULUM_DIR/L2-advanced/02-interest-rate-policy.md" \
    "利率 货币政策 央行 美联储 降准降息 存款准备金率 2026"

search_topic "经济周期" "$CURRICULUM_DIR/L2-advanced/03-economic-cycle.md" \
    "经济周期 复苏繁荣衰退萧条 美林时钟 周期投资 2026"

search_topic "波特五力模型" "$CURRICULUM_DIR/L2-advanced/04-porter-five-forces.md" \
    "波特五力模型 行业分析 竞争格局 供应商 购买者 2026"

search_topic "财务报表基础" "$CURRICULUM_DIR/L2-advanced/05-financial-statements.md" \
    "财务报表 资产负债表 利润表 现金流量表 三表分析 2026"

search_topic "财务比率分析" "$CURRICULUM_DIR/L2-advanced/06-financial-ratios.md" \
    "财务比率分析 ROE ROA 毛利率 净利率 杜邦分析 2026"

search_topic "PE 估值法" "$CURRICULUM_DIR/L2-advanced/07-pe-valuation.md" \
    "PE 市盈率 估值方法 PEG 相对估值 可比公司 2026"

search_topic "PB 与 PS 估值" "$CURRICULUM_DIR/L2-advanced/08-pb-ps-valuation.md" \
    "PB 市净率 PS 市销率 EV EBITDA 估值指标 2026"

search_topic "DCF 估值基础" "$CURRICULUM_DIR/L2-advanced/09-dcf-basics.md" \
    "DCF 现金流折现 自由现金流 估值模型 2026"

# L3 专业阶段
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${PURPLE}L3 专业阶段 (1-3 年)${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

search_topic "DCF 详细建模" "$CURRICULUM_DIR/L3-professional/01-dcf-modeling.md" \
    "DCF 详细建模 WACC 加权平均资本成本 终值计算 敏感性分析 2026"

search_topic "期权基础与定价" "$CURRICULUM_DIR/L3-professional/02-options-basics.md" \
    "期权基础 看涨看跌期权 Black-Scholes 定价 2026"

search_topic "期货与衍生品" "$CURRICULUM_DIR/L3-professional/03-futures-derivatives.md" \
    "期货 衍生品 远期 互换 基差 套期保值 2026"

search_topic "因子模型" "$CURRICULUM_DIR/L3-professional/04-factor-models.md" \
    "因子模型 Fama-French 三因子 五因子 CAPM 2026"

search_topic "现代投资组合理论" "$CURRICULUM_DIR/L3-professional/05-modern-portfolio.md" \
    "现代投资组合理论 MPT 有效前沿 资本市场线 马科维茨 2026"

search_topic "资产配置策略" "$CURRICULUM_DIR/L3-professional/06-asset-allocation.md" \
    "资产配置 战略配置 战术配置 风险平价 全天候 2026"

# 生成知识库索引
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo "生成知识库索引..."
echo ""

{
    echo "# InvestEdu 知识库索引"
    echo ""
    echo "**更新时间**: $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo "---"
    echo ""
    echo "## L1 基础阶段"
    echo ""
    find "$CURRICULUM_DIR/L1-basics" -name "*.md" -type f | sort | while read -r file; do
        name=$(basename "$file" .md | sed 's/^[0-9]*-//')
        echo "- [$name]($file)"
    done
    echo ""
    echo "## L2 进阶阶段"
    echo ""
    find "$CURRICULUM_DIR/L2-advanced" -name "*.md" -type f | sort | while read -r file; do
        name=$(basename "$file" .md | sed 's/^[0-9]*-//')
        echo "- [$name]($file)"
    done
    echo ""
    echo "## L3 专业阶段"
    echo ""
    find "$CURRICULUM_DIR/L3-professional" -name "*.md" -type f | sort | while read -r file; do
        name=$(basename "$file" .md | sed 's/^[0-9]*-//')
        echo "- [$name]($file)"
    done
    echo ""
} > "$REFERENCES_DIR/knowledge-index.md"

# 完成
echo -e "${GREEN}✅ 完整知识库构建完成！${NC}"
echo ""
echo "📁 知识文件统计:"
echo "  L1 基础阶段：$(find "$CURRICULUM_DIR/L1-basics" -name "*.md" | wc -l) 个文件"
echo "  L2 进阶阶段：$(find "$CURRICULUM_DIR/L2-advanced" -name "*.md" | wc -l) 个文件"
echo "  L3 专业阶段：$(find "$CURRICULUM_DIR/L3-professional" -name "*.md" | wc -l) 个文件"
echo ""
echo "📄 知识库索引：$REFERENCES_DIR/knowledge-index.md"
echo ""
echo "💡 使用方法:"
echo "  • 查看索引：cat $REFERENCES_DIR/knowledge-index.md"
echo "  • 搜索知识：grep -r \"关键词\" $CURRICULUM_DIR/"
echo "  • 学习模块：cat curriculum/L1-basics/01-investment-basics.md"
echo ""
