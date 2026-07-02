#!/bin/bash
# assess-level.sh - 投资知识水平评估

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_DIR="$SKILL_DIR/config"
PROGRESS_DIR="$SKILL_DIR/progress"

mkdir -p "$CONFIG_DIR" "$PROGRESS_DIR"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# 评估问题库
declare -a QUESTIONS_L1=(
    "什么是股票？|A.公司所有权凭证|B.债务凭证|C.存款凭证|A"
    "复利是指？|A.利滚利|B.单利|C.固定利息|A"
    "以下哪个风险最高？|A.国债|B.股票|C.货币基金|B"
    "通货膨胀会导致？|A.购买力下降|B.购买力上升|C.无影响|A"
    "ETF 是什么？|A.交易所交易基金|B.银行存款|C.保险产品|A"
)

declare -a QUESTIONS_L2=(
    "GDP 是指？|A.国内生产总值|B.国民生产总值|C.人均收入|A"
    "PE 比率是？|A.市盈率|B.市净率|C.市销率|A"
    "现金流量表不包括？|A.经营现金流|B.投资现金流|C.利润现金流|C"
    "波特五力不包括？|A.供应商议价能力|B.政府监管|C.替代品威胁|B"
    "DCF 是？|A.现金流折现|B.股息计算|C.折旧方法|A"
)

declare -a QUESTIONS_L3=(
    "WACC 是指？|A.加权平均资本成本|B.债务成本|C.权益成本|A"
    "期权 Delta 表示？|A.价格敏感度|B.时间衰减|C.波动率敏感度|A"
    "夏普比率衡量？|A.风险调整后收益|B.绝对收益|C.最大回撤|A"
    "VaR 是指？|A.风险价值|B.变动率|C.估值调整|A"
    "Fama-French 三因子不包括？|A.市场因子|B.规模因子|C.动量因子|C"
)

# 计分
score=0
max_score=0

# 显示问题函数
ask_questions() {
    local level="$1"
    shift
    local questions=("$@")
    
    echo -e "${CYAN}━━━ $level 测试题 ━━━${NC}"
    echo ""
    
    for q in "${questions[@]}"; do
        IFS='|' read -r question opt1 opt2 opt3 answer <<< "$q"
        
        echo "❓ $question"
        echo "   A) $opt1"
        echo "   B) $opt2"
        echo "   C) $opt3"
        echo -n "   你的答案 (A/B/C): "
        read -r user_answer
        
        user_answer=$(echo "$user_answer" | tr '[:lower:]' '[:upper:]')
        
        if [[ "$user_answer" == "$answer" ]]; then
            echo -e "   ${GREEN}✓ 正确${NC}"
            ((score++))
        else
            echo -e "   ${RED}✗ 错误，正确答案：$answer${NC}"
        fi
        echo ""
        ((max_score++))
    done
}

# 主函数
main() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     📝 InvestEdu 水平评估测试              ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "📅 测试时间：$timestamp"
    echo ""
    echo "说明：本测试共 15 道题，分为 L1/L2/L3 三个等级"
    echo "     请根据自己的知识水平作答"
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    
    # L1 测试
    ask_questions "L1 基础" "${QUESTIONS_L1[@]}"
    
    # L2 测试
    ask_questions "L2 进阶" "${QUESTIONS_L2[@]}"
    
    # L3 测试
    ask_questions "L3 专业" "${QUESTIONS_L3[@]}"
    
    # 计算结果
    local percentage=$((score * 100 / max_score))
    
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "📊 测试结果"
    echo ""
    echo "  得分：$score / $max_score ($percentage%)"
    echo ""
    
    # 评估等级
    local level="入门"
    local recommendation=""
    
    if [[ $score -ge 13 ]]; then
        level="专业"
        recommendation="建议进入 L3 专业阶段学习，可深入研究估值建模、衍生品或量化投资"
    elif [[ $score -ge 10 ]]; then
        level="进阶"
        recommendation="建议继续 L2 进阶阶段学习，重点加强财报分析和估值方法"
    elif [[ $score -ge 6 ]]; then
        level="基础"
        recommendation="建议完成 L1 基础阶段学习，打好投资基础概念"
    else
        level="新手"
        recommendation="建议从 L1 基础阶段开始，系统学习投资基础知识"
    fi
    
    echo -e "  评估等级：${GREEN}$level${NC}"
    echo ""
    echo "  📌 学习建议:"
    echo "     $recommendation"
    echo ""
    
    # 保存结果
    local result_file="$PROGRESS_DIR/assessment-$(date +%Y%m%d).json"
    cat > "$result_file" << EOF
{
    "date": "$timestamp",
    "score": $score,
    "max_score": $max_score,
    "percentage": $percentage,
    "level": "$level",
    "recommendation": "$recommendation"
}
EOF
    
    echo "📄 测试结果已保存：$result_file"
    echo ""
    
    # 更新用户档案
    local profile_file="$CONFIG_DIR/user-profile.json"
    if [[ -f "$profile_file" ]]; then
        # 更新现有档案
        local tmp_file=$(mktemp)
        jq --arg level "$level" '.currentLevel = $level' "$profile_file" > "$tmp_file" 2>/dev/null && mv "$tmp_file" "$profile_file"
    else
        # 创建新档案
        cat > "$profile_file" << EOF
{
    "name": "投资者",
    "currentLevel": "$level",
    "assessmentDate": "$timestamp",
    "assessmentScore": $score,
    "goals": [],
    "completedModules": [],
    "timePerWeek": 10
}
EOF
    fi
    
    echo ""
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "💡 下一步:"
    echo "  • 查看知识体系：show-framework.sh"
    echo "  • 规划学习路径：plan-learning.sh \"我想学习...\""
    echo "  • 查看推荐书单：cat references/book-list.md"
    echo ""
}

# 执行
main "$@"
