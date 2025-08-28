#!/bin/bash
# daily-setup.sh - Prepares your daily coding environment

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Starting daily coding session...${NC}"
echo -e "${BLUE}📅 Date: $(date +%Y-%m-%d)${NC}"
echo "----------------------------------------"

# Navigate to main directory
cd ~/Documents/coding-practice/my-HackerRank-LeetCode-Progress/

# Update README with current stats first
echo -e "${YELLOW}📊 Updating README with current statistics...${NC}"
./scripts/update-readme.sh
echo "----------------------------------------"

# Open necessary files in VS Code
echo -e "${YELLOW}📁 Opening planning files...${NC}"
code PROGRESS.md
code DAILY_LOG.md
code goals.json

# Show today's goals
echo -e "${GREEN}🎯 Today's Focus:${NC}"
TODAY_GOALS=$(grep -A 3 -B 1 "| $(date +%a) |" PROGRESS.md | head -8)
if [ -n "$TODAY_GOALS" ]; then
    echo "$TODAY_GOALS"
else
    echo "No specific goals set for today. Check PROGRESS.md to add them!"
fi

# Show streak info
CURRENT_STREAK=$(python3 -c "
import json
try:
    with open('goals.json', 'r') as f:
        data = json.load(f)
    print(data.get('streaks', {}).get('current', '0'))
except:
    print('0')
" 2>/dev/null)

TOTAL_SOLVED=$(python3 -c "
import json
try:
    with open('goals.json', 'r') as f:
        data = json.load(f)
    print(data.get('total_completed', '0'))
except:
    print('0')
" 2>/dev/null)

echo -e "${BLUE}🔥 Current Streak: ${CURRENT_STREAK} days${NC}"
echo -e "${BLUE}📊 Total Solved: ${TOTAL_SOLVED} problems${NC}"
echo "----------------------------------------"

# Open today's target language folder
TODAY=$(date +%a)
case $TODAY in
  "Mon"|"Wed")
    echo -e "${GREEN}🐍 Today is Python day!${NC}"
    echo "Focus: Python programming and algorithms"
    code hackerrank/python/
    code leetcode/python/
    ;;
  "Tue"|"Thu")
    echo -e "${GREEN}☕ Today is Java day!${NC}"
    echo "Focus: Java OOP and data structures"
    code hackerrank/java/
    code leetcode/java/
    ;;
  "Fri"|"Sat")
    echo -e "${GREEN}⚙️ Today is C day!${NC}"
    echo "Focus: C programming and system concepts"
    code hackerrank/c/
    code leetcode/c/
    ;;
  "Sun")
    echo -e "${GREEN}📊 Review day! Time to plan next week.${NC}"
    echo "Activities: Weekly review, progress analysis, and planning"
    code docs/
    # Generate weekly report
    echo -e "${YELLOW}📈 Generating weekly report...${NC}"
    python3 scripts/generate-stats.py
    ;;
esac

echo "----------------------------------------"
echo -e "${GREEN}✅ Daily setup complete! Happy coding! 🎉${NC}"

# Show motivational quote
QUOTES=(
    "The only way to learn to code is to code. Daily. 🚀"
    "Consistency is the key to mastery. 🔑"
    "Every problem solved is a step forward. 👣"
    "Your future self will thank you for today's effort. 🙏"
    "Code is poetry in motion. ✨"
)
RANDOM_QUOTE=${QUOTES[$RANDOM % ${#QUOTES[@]}]}
echo -e "${BLUE}💡 ${RANDOM_QUOTE}${NC}"