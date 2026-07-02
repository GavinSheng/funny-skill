#!/bin/bash
# quiz.sh - 投资知识测试

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
PROGRESS_DIR="$SKILL_DIR/progress"

mkdir -p "$PROGRESS_DIR"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 题库
declare -A QUIZ_STOCK=(
    ["股票是什么？|A.公司所有权凭证|B.债务凭证|C.存款凭证|A|股票是最基本的投资概念，代表对公司的部分所有权。"]
    ["以下哪个不是股票交易所？|A.上交所|B.深交所|C.央行|C|央行是货币政策机构，不是证券交易所。"]
    ["普通股股东享有什么权利？|A.投票权|B.固定利息|C.优先清偿|A|普通股股东有投票权，债权人才有固定利息。"]
    ["股票涨跌停板限制是？|A.5%|B.10%|C.20%|B|A 股主板涨跌停限制为 10%。"]
)

declare -A QUIZ_VALUATION=(
    ["PE 是指？|A.市盈率|B.市净率|C.市销率|A|PE=Price/Earnings，即市盈率。"]
    ["DCF 方法的核心是？|A.历史利润|B.未来现金流|C.净资产|B|DCF 基于未来自由现金流折现。"]
    ["以下哪个适合用 PB 估值？|A.科技公司|B.银行|C.服务业|B|银行等重资产公司适合 PB 估值。"]
    ["WACC 是指？|A.权益成本|B.债务成本|C.加权平均资本成本|C|WACC=Weighted Average Cost of Capital。"]
)

declare -A QUIZ_FINANCIAL=(
    ["资产负债表的基本公式是？|A.资产=负债 + 所有者权益|B.资产=收入 - 支出|C.利润=收入 - 成本|A|这是会计恒等式。"]
    ["ROE 是指？|A.总资产收益率|B.净资产收益率|C.销售利润率|B|ROE=Return on Equity，净资产收益率。"]
    ["经营活动现金流为正说明？|A.主业赚钱|B.投资赚钱|C.融资赚钱|A|经营现金流为正说明主业能产生现金。"]
    ["毛利率=？|A.(收入 - 成本)/收入|B.利润/收入|C.现金流/收入|A|毛利率反映产品盈利能力。"]
)

declare -A QUIZ_MACRO=(
    ["GDP 是指？|A.国内生产总值|B.国民生产总值|C.人均收入|A|GDP=Gross Domestic Product。"]
    ["央行加息通常对股市是？|A.利好|B.利空|C.无影响|B|加息提高资金成本，通常利空股市。"]
    ["CPI 衡量的是？|A.生产者价格|B.消费者价格|C.进出口价格|B|CPI=Consumer Price Index，消费者价格指数。"]
    ["经济周期不包括？|A.复苏|B.繁荣|C.永久增长|C|经济周期包括复苏、繁荣、衰退、萧条。"]
)

# 显示帮助
show_help() {
    echo "用法：quiz.sh <主题>"
    echo ""
    echo "可用主题:"
    echo "  stock      - 股票基础"
    echo "  valuation  - 估值分析"
    echo "  financial  - 财务分析"
    echo "  macro      - 宏观经济"
    echo "  all        - 综合测试"
    echo ""
    echo "示例:"
    echo "  quiz.sh stock"
    echo "  quiz.sh valuation"
    echo "  quiz.sh all"
}

# 进行测试
run_quiz() {
    local topic="$1"
    local -n quiz_array="$topic"
    
    local score=0
    local total=0
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     📝 InvestEdu 知识测试：$topic                  ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    
    for question_data in "${quiz_array[@]}"; do
        IFS='|' read -r question opt1 opt2 opt3 answer explanation <<< "$question_data"
        
        echo "❓ $question"
        echo "   A) $opt1"
        echo "   B) $opt2"
        echo "   C) $opt3"
        echo -n "   你的答案 (A/B/C): "
        read -r user_answer
        
        user_answer=$(echo "$user_answer" | tr '[:lower:]' '[:upper:]')
        ((total++))
        
        if [[ "$user_answer" == "$answer" ]]; then
            echo -e "   ${GREEN}✓ 正确${NC}"
            ((score++))
        else
            echo -e "   ${RED}✗ 错误${NC}"
            echo -e "   💡 正确答案：$answer"
        fi
        echo -e "   📖 解析：$explanation"
        echo ""
    done
    
    # 计算得分
    local percentage=$((score * 100 / total))
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "📊 测试结果"
    echo ""
    echo "  得分：$score / $total ($percentage%)"
    echo ""
    
    # 评价
    local rating=""
    if [[ $percentage -ge 90 ]]; then
        rating="${GREEN}优秀🌟${NC}"
    elif [[ $percentage -ge 70 ]]; then
        rating="${CYAN}良好👍${NC}"
    elif [[ $percentage -ge 60 ]]; then
        rating="${YELLOW}及格📚${NC}"
    else
        rating="${RED}需努力💪${NC}"
    fi
    
    echo "  评级：$rating"
    echo ""
    
    # 保存结果
    local result_file="$PROGRESS_DIR/quiz-${topic}-$(date +%Y%m%d).json"
    cat > "$result_file" << EOF
{
    "topic": "$topic",
    "date": "$(date '+%Y-%m-%d %H:%M:%S')",
    "score": $score,
    "total": $total,
    "percentage": $percentage
}
EOF
    
    echo "📄 结果已保存：$result_file"
    echo ""
}

# 综合测试
run_all_quiz() {
    echo "╔════════════════════════════════════════════╗"
    echo "║     📝 InvestEdu 综合知识测试              ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "将进行 4 个主题的测试，共 16 道题"
    echo ""
    
    local total_score=0
    local total_questions=0
    
    # 股票
    run_quiz_single "QUIZ_STOCK" "股票基础"
    total_score=$((total_score + $?))
    total_questions=$((total_questions + 4))
    
    # 估值
    run_quiz_single "QUIZ_VALUATION" "估值分析"
    total_score=$((total_score + $?))
    total_questions=$((total_questions + 4))
    
    # 财务
    run_quiz_single "QUIZ_FINANCIAL" "财务分析"
    total_score=$((total_score + $?))
    total_questions=$((total_questions + 4))
    
    # 宏观
    run_quiz_single "QUIZ_MACRO" "宏观经济"
    total_score=$((total_score + $?))
    total_questions=$((total_questions + 4))
    
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "📊 综合结果"
    echo ""
    echo "  总得分：$total_score / $total_questions"
    
    local percentage=$((total_score * 100 / total_questions))
    echo "  正确率：$percentage%"
}

# 主函数
main() {
    if [[ $# -lt 1 ]] || [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
        show_help
        exit 0
    fi
    
    local topic="$1"
    
    case "$topic" in
        stock)
            run_quiz QUIZ_STOCK
            ;;
        valuation)
            run_quiz QUIZ_VALUATION
            ;;
        financial)
            run_quiz QUIZ_FINANCIAL
            ;;
        macro)
            run_quiz QUIZ_MACRO
            ;;
        all)
            run_all_quiz
            ;;
        *)
            echo -e "${RED}未知主题：$topic${NC}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# 执行
main "$@"
