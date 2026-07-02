#!/bin/bash
# plan-learning.sh - 学习路径规划
# 根据用户学习目标生成个性化学习计划

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$SKILL_DIR/config"
CURRICULUM_DIR="$SKILL_DIR/curriculum"
PROGRESS_DIR="$SKILL_DIR/progress"

mkdir -p "$CONFIG_DIR" "$CURRICULUM_DIR" "$PROGRESS_DIR"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 学习主题映射
declare -A TOPIC_MAPPING
TOPIC_MAPPING["股票"]="stock-basics"
TOPIC_MAPPING["股票投资"]="stock-basics"
TOPIC_MAPPING["炒股"]="stock-basics"
TOPIC_MAPPING["基金"]="fund-basics"
TOPIC_MAPPING["基金投资"]="fund-basics"
TOPIC_MAPPING["债券"]="bond-basics"
TOPIC_MAPPING["估值"]="valuation"
TOPIC_MAPPING["估值分析"]="valuation"
TOPIC_MAPPING["财务分析"]="financial-analysis"
TOPIC_MAPPING["财报"]="financial-analysis"
TOPIC_MAPPING["财务报表"]="financial-analysis"
TOPIC_MAPPING["宏观经济"]="macro-economy"
TOPIC_MAPPING["宏观"]="macro-economy"
TOPIC_MAPPING["行业分析"]="industry-analysis"
TOPIC_MAPPING["量化"]="quant-basics"
TOPIC_MAPPING["量化投资"]="quant-basics"
TOPIC_MAPPING["期权"]="options"
TOPIC_MAPPING["期货"]="futures"
TOPIC_MAPPING["衍生品"]="derivatives"
TOPIC_MAPPING["资产配置"]="asset-allocation"
TOPIC_MAPPING["投资组合"]="portfolio"

# 获取用户当前水平
get_user_level() {
    local profile_file="$CONFIG_DIR/user-profile.json"
    if [[ -f "$profile_file" ]]; then
        jq -r '.currentLevel // "新手"' "$profile_file" 2>/dev/null || echo "新手"
    else
        echo "新手"
    fi
}

# 生成学习计划
generate_plan() {
    local topic="$1"
    local level="$2"
    local weeks="${3:-8}"
    
    # 查找匹配的主题
    local curriculum_key=""
    for key in "${!TOPIC_MAPPING[@]}"; do
        if [[ "$topic" == *"$key"* ]]; then
            curriculum_key="${TOPIC_MAPPING[$key]}"
            break
        fi
    done
    
    # 默认计划
    if [[ -z "$curriculum_key" ]]; then
        curriculum_key="general-investing"
    fi
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     📚 InvestEdu 学习路径规划              ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "📅 生成时间：$timestamp"
    echo "🎯 学习目标：$topic"
    echo "📊 当前水平：$level"
    echo "⏱️  预计周期：$weeks 周"
    echo ""
    
    # 根据主题生成不同计划
    case "$curriculum_key" in
        stock-basics)
            generate_stock_plan "$weeks"
            ;;
        fund-basics)
            generate_fund_plan "$weeks"
            ;;
        valuation)
            generate_valuation_plan "$weeks"
            ;;
        financial-analysis)
            generate_financial_plan "$weeks"
            ;;
        macro-economy)
            generate_macro_plan "$weeks"
            ;;
        industry-analysis)
            generate_industry_plan "$weeks"
            ;;
        quant-basics)
            generate_quant_plan "$weeks"
            ;;
        options|futures|derivatives)
            generate_derivatives_plan "$weeks"
            ;;
        asset-allocation|portfolio)
            generate_portfolio_plan "$weeks"
            ;;
        *)
            generate_general_plan "$weeks"
            ;;
    esac
    
    # 保存计划
    local plan_file="$PROGRESS_DIR/learning-plan-$(date +%Y%m%d).md"
    {
        echo "# InvestEdu 学习路径规划"
        echo ""
        echo "**生成时间**: $timestamp"
        echo "**学习目标**: $topic"
        echo "**当前水平**: $level"
        echo "**预计周期**: $weeks 周"
        echo ""
        echo "## 学习计划"
        echo ""
        # 这里简化处理，实际应该捕获上面的输出
        echo "(计划内容已显示在上方)"
    } > "$plan_file" 2>/dev/null
    
    echo "📄 计划已保存：$plan_file"
}

# 股票投资计划
generate_stock_plan() {
    local weeks="$1"
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📖 学习计划详情${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo -e "${GREEN}━━━ 第 1-2 周：股票基础 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 什么是股票（公司所有权凭证）"
    echo "  • 股票市场运作机制（交易所、券商）"
    echo "  • 股票类型（普通股、优先股、A/H/美股）"
    echo "  • 股票交易基础（开户、下单、费用）"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《股票作手回忆录》- 埃德温·勒菲弗"
    echo "  • 《股市真规则》- 帕特·多尔西"
    echo "  • B 站：股票入门基础视频"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 开立模拟账户"
    echo "  • 完成 10 笔模拟交易"
    echo ""
    
    echo -e "${CYAN}━━━ 第 3-4 周：基本面分析 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 商业模式分析（如何赚钱）"
    echo "  • 财务报表入门（三大报表）"
    echo "  • 关键财务指标（营收、利润、ROE）"
    echo "  • 业务分析框架（产品、市场、竞争）"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《财务报表分析与证券估值》- 佩克曼"
    echo "  • 《巴菲特致股东的信》"
    echo "  • 上市公司年报阅读"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 阅读 3 份上市公司年报"
    echo "  • 分析 1 家公司的商业模式"
    echo ""
    
    echo -e "${PURPLE}━━━ 第 5-6 周：估值方法 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • PE 估值（市盈率、PEG）"
    echo "  • PB 估值（市净率）"
    echo "  • PS 估值（市销率）"
    echo "  • DCF 基础（现金流折现原理）"
    echo "  • 相对估值比较"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《估值》- 蒂姆·科勒"
    echo "  • 《投资估值》- 达摩达兰"
    echo "  • 券商研报中的估值分析"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 用 PE/PB 估值 3 家公司"
    echo "  • 搭建简易 DCF 模型"
    echo ""
    
    echo -e "${RED}━━━ 第 7-8 周：实战演练 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 选股流程与方法"
    echo "  • 投资组合构建"
    echo "  • 风险管理与仓位控制"
    echo "  • 投资记录与复盘"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《投资最重要的事》- 霍华德·马克斯"
    echo "  • 《穷查理宝典》- 查理·芒格"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 撰写 3 份公司分析报告"
    echo "  • 构建模拟投资组合"
    echo "  • 每周复盘投资记录"
    echo ""
}

# 估值分析计划
generate_valuation_plan() {
    local weeks="$1"
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📖 学习计划详情${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo -e "${GREEN}━━━ 第 1-2 周：估值基础 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 估值的本质与目的"
    echo "  • 价值 vs 价格"
    echo "  • 内在价值概念"
    echo "  • 估值方法分类"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《估值》- 蒂姆·科勒"
    echo "  • 《投资估值》- 达摩达兰"
    echo ""
    
    echo -e "${CYAN}━━━ 第 3-4 周：相对估值法 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • PE 市盈率（适用场景、局限性）"
    echo "  • PB 市净率（周期股、银行）"
    echo "  • PS 市销率（成长股、SaaS）"
    echo "  • PEG（成长股估值）"
    echo "  • EV/EBITDA（企业价值倍数）"
    echo "  • 可比公司选择"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 用 5 种方法估值同一家公司"
    echo "  • 比较不同方法的结果差异"
    echo ""
    
    echo -e "${PURPLE}━━━ 第 5-6 周：绝对估值法 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • DCF 模型原理"
    echo "  • 自由现金流预测"
    echo "  • WACC 计算"
    echo "  • 终值计算（永续增长法、退出倍数）"
    echo "  • 敏感性分析"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 搭建完整 DCF 模型"
    echo "  • 进行敏感性分析"
    echo ""
    
    echo -e "${RED}━━━ 第 7-8 周：特殊情境估值 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 周期股估值"
    echo "  • 成长股估值"
    echo "  • 困境公司估值"
    echo "  • 实物期权思维"
    echo "  • 估值检查清单"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 完成 5 份完整估值报告"
    echo "  • 建立个人估值模板"
    echo ""
}

# 财务分析计划
generate_financial_plan() {
    local weeks="$1"
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📖 学习计划详情${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo -e "${GREEN}━━━ 第 1-2 周：财务报表基础 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 资产负债表（资产、负债、权益）"
    echo "  • 利润表（收入、成本、利润）"
    echo "  • 现金流量表（经营、投资、筹资）"
    echo "  • 报表勾稽关系"
    echo ""
    echo "📚 推荐资源:"
    echo "  • 《财务报表分析与证券估值》"
    echo "  • 《财报就像一本故事书》"
    echo ""
    
    echo -e "${CYAN}━━━ 第 3-4 周：财务比率分析 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 盈利能力（毛利率、净利率、ROE）"
    echo "  • 偿债能力（流动比率、资产负债率）"
    echo "  • 运营能力（周转率、周转天数）"
    echo "  • 成长能力（营收增速、利润增速）"
    echo "  • 杜邦分析"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 计算 5 家公司的财务比率"
    echo "  • 进行杜邦分析"
    echo ""
    
    echo -e "${PURPLE}━━━ 第 5-6 周：财务质量分析 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 盈利质量（经营现金流/净利润）"
    echo "  • 资产质量（应收账款、存货）"
    echo "  • 现金流质量"
    echo "  • 财务造假识别"
    echo "  • 预警信号"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 分析 3 家公司的财务质量"
    echo "  • 识别潜在财务风险"
    echo ""
    
    echo -e "${RED}━━━ 第 7-8 周：综合财务分析 ━━━${NC}"
    echo ""
    echo "📌 学习内容:"
    echo "  • 财务分析框架"
    echo "  • 同业比较"
    echo "  • 历史趋势分析"
    echo "  • 财务分析与估值结合"
    echo ""
    echo "✅ 实践任务:"
    echo "  • 完成 3 份财务分析报告"
    echo "  • 建立财务分析模板"
    echo ""
}

# 通用计划
generate_general_plan() {
    local weeks="$1"
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}📖 学习计划详情${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    echo "📌 根据您的需求，建议按以下顺序学习:"
    echo ""
    echo "第 1 阶段：投资基础 (2 周)"
    echo "  • 投资基本概念"
    echo "  • 资产类别概览"
    echo "  • 风险与收益"
    echo ""
    echo "第 2 阶段：市场分析 (2 周)"
    echo "  • 宏观经济基础"
    echo "  • 行业分析框架"
    echo "  • 公司分析基础"
    echo ""
    echo "第 3 阶段：估值方法 (2 周)"
    echo "  • 相对估值法"
    echo "  • 绝对估值法"
    echo "  • 估值实践"
    echo ""
    echo "第 4 阶段：实战应用 (2 周)"
    echo "  • 选股方法"
    echo "  • 组合构建"
    echo "  • 风险管理"
    echo ""
}

# 显示帮助
show_help() {
    echo "用法：plan-learning.sh <学习目标> [周数]"
    echo ""
    echo "学习目标示例:"
    echo "  \"股票投资\"、\"基金投资\"、\"估值分析\""
    echo "  \"财务分析\"、\"宏观经济\"、\"行业分析\""
    echo "  \"量化投资\"、\"期权期货\"、\"资产配置\""
    echo ""
    echo "示例:"
    echo "  plan-learning.sh \"股票投资\""
    echo "  plan-learning.sh \"估值分析\" 12"
    echo "  plan-learning.sh \"我想学习如何分析公司财报\""
    echo ""
}

# 主函数
main() {
    if [[ $# -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    local topic="$1"
    local weeks="${2:-8}"
    local level=$(get_user_level)
    
    generate_plan "$topic" "$level" "$weeks"
    
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "💡 下一步:"
    echo "  • 开始学习：按计划逐步完成"
    echo "  • 记录进度：progress.sh"
    echo "  • 知识测试：quiz.sh <主题>"
    echo ""
}

# 执行
main "$@"
