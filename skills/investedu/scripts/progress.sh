#!/bin/bash
# progress.sh - 学习进度跟踪

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

# 主函数
main() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local profile_file="$CONFIG_DIR/user-profile.json"
    
    echo "╔════════════════════════════════════════════╗"
    echo "║     📊 InvestEdu 学习进度                  ║"
    echo "╚════════════════════════════════════════════╝"
    echo ""
    echo "📅 查询时间：$timestamp"
    echo ""
    
    # 检查用户档案
    if [[ ! -f "$profile_file" ]]; then
        echo -e "${YELLOW}⚠️  尚未创建用户档案${NC}"
        echo ""
        echo "请先运行:"
        echo "  assess-level.sh    # 评估当前水平"
        echo "  plan-learning.sh \"学习目标\"  # 创建学习计划"
        echo ""
        exit 0
    fi
    
    # 读取用户信息
    local name=$(jq -r '.name // "投资者"' "$profile_file" 2>/dev/null)
    local level=$(jq -r '.currentLevel // "新手"' "$profile_file" 2>/dev/null)
    local start_date=$(jq -r '.startDate // "未设置"' "$profile_file" 2>/dev/null)
    local goals=$(jq -r '.goals // [] | join(", ")' "$profile_file" 2>/dev/null)
    local time_per_week=$(jq -r '.timePerWeek // 10' "$profile_file" 2>/dev/null)
    
    echo -e "${BLUE}━━━ 用户信息 ━━━${NC}"
    echo ""
    echo "  👤 姓名：$name"
    echo "  📊 当前水平：$level"
    echo "  📅 开始日期：$start_date"
    echo "  🎯 学习目标：${goals:-未设置}"
    echo "  ⏱️  每周学习时间：${time_per_week}小时"
    echo ""
    
    # 显示已完成模块
    echo -e "${BLUE}━━━ 已完成模块 ━━━${NC}"
    echo ""
    
    local completed=$(jq -r '.completedModules // []' "$profile_file" 2>/dev/null)
    local completed_count=$(echo "$completed" | jq 'length' 2>/dev/null || echo "0")
    
    if [[ "$completed_count" -gt 0 ]]; then
        echo "$completed" | jq -r '.[] | "  ✅ " + .' 2>/dev/null
        echo ""
        echo "  已完成：$completed_count 个模块"
    else
        echo "  (暂无完成记录)"
        echo ""
        echo "  💡 提示：完成学习后运行:"
        echo "     progress.sh --complete \"模块名称\""
    fi
    echo ""
    
    # 显示学习统计
    echo -e "${BLUE}━━━ 学习统计 ━━━${NC}"
    echo ""
    
    # 计算学习天数
    if [[ "$start_date" != "未设置" ]]; then
        local start_seconds=$(date -d "$start_date" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$start_date" +%s 2>/dev/null || echo "0")
        local now_seconds=$(date +%s)
        local days=$(( (now_seconds - start_seconds) / 86400 ))
        echo "  📅 已学习：$days 天"
    else
        echo "  📅 已学习：-- 天"
    fi
    
    # 统计评估历史
    local assessments=$(ls -1 "$PROGRESS_DIR"/assessment-*.json 2>/dev/null | wc -l || echo "0")
    echo "  📝 评估次数：$assessments"
    
    # 统计学习计划
    local plans=$(ls -1 "$PROGRESS_DIR"/learning-plan-*.md 2>/dev/null | wc -l || echo "0")
    echo "  📋 学习计划：$plans 个"
    
    # 统计测试记录
    local quizzes=$(ls -1 "$PROGRESS_DIR"/quiz-*.json 2>/dev/null | wc -l || echo "0")
    echo "  ✅ 测试次数：$quizzes"
    echo ""
    
    # 显示最近评估结果
    echo -e "${BLUE}━━━ 最近评估 ━━━${NC}"
    echo ""
    
    local latest_assessment=$(ls -1t "$PROGRESS_DIR"/assessment-*.json 2>/dev/null | head -1)
    if [[ -n "$latest_assessment" ]] && [[ -f "$latest_assessment" ]]; then
        local score=$(jq -r '.score // 0' "$latest_assessment" 2>/dev/null)
        local max_score=$(jq -r '.max_score // 0' "$latest_assessment" 2>/dev/null)
        local assess_level=$(jq -r '.level // "未知"' "$latest_assessment" 2>/dev/null)
        local assess_date=$(jq -r '.date // "未知"' "$latest_assessment" 2>/dev/null)
        
        echo "  📊 得分：$score / $max_score"
        echo "  📈 等级：$assess_level"
        echo "  📅 日期：$assess_date"
    else
        echo "  (暂无评估记录)"
        echo ""
        echo "  💡 提示：运行 assess-level.sh 进行水平评估"
    fi
    echo ""
    
    # 学习建议
    echo -e "${BLUE}━━━ 学习建议 ━━━${NC}"
    echo ""
    
    case "$level" in
        "新手"|"入门")
            echo "  📌 建议从 L1 基础阶段开始学习"
            echo "  📚 推荐：《小狗钱钱》《股票作手回忆录》"
            echo "  🎯 目标：掌握投资基本概念"
            ;;
        "基础")
            echo "  📌 建议继续 L2 进阶阶段学习"
            echo "  📚 推荐：《财务报表分析与证券估值》"
            echo "  🎯 目标：掌握财报分析和基础估值"
            ;;
        "进阶")
            echo "  📌 建议进入 L3 专业阶段学习"
            echo "  📚 推荐：《估值》《投资估值》"
            echo "  🎯 目标：深入估值建模和专业分析"
            ;;
        "专业")
            echo "  📌 建议 L4 专家阶段深入学习"
            echo "  📚 推荐：《证券分析》《聪明的投资者》"
            echo "  🎯 目标：形成投资框架和实战能力"
            ;;
        *)
            echo "  📌 建议继续当前阶段学习"
            ;;
    esac
    echo ""
    
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "💡 常用命令:"
    echo "  • 评估水平：assess-level.sh"
    echo "  • 规划学习：plan-learning.sh \"学习目标\""
    echo "  • 完成模块：progress.sh --complete \"模块名称\""
    echo "  • 知识测试：quiz.sh <主题>"
    echo ""
}

# 完成模块
complete_module() {
    local module="$1"
    local profile_file="$CONFIG_DIR/user-profile.json"
    
    if [[ ! -f "$profile_file" ]]; then
        echo -e "${YELLOW}⚠️  请先创建用户档案${NC}"
        exit 1
    fi
    
    # 添加完成记录
    local tmp_file=$(mktemp)
    jq --arg module "$module" \
       --arg date "$(date '+%Y-%m-%d')" \
       '.completedModules += [{"name": $module, "completedAt": $date}]' \
       "$profile_file" > "$tmp_file" 2>/dev/null && mv "$tmp_file" "$profile_file"
    
    echo -e "${GREEN}✅ 已完成模块：$module${NC}"
    echo "  日期：$(date '+%Y-%m-%d')"
}

# 解析参数
case "${1:-}" in
    --complete|-c)
        if [[ -z "$2" ]]; then
            echo "请指定模块名称"
            exit 1
        fi
        complete_module "$2"
        ;;
    --reset|-r)
        rm -f "$CONFIG_DIR/user-profile.json"
        echo "用户档案已重置"
        ;;
    *)
        main
        ;;
esac
