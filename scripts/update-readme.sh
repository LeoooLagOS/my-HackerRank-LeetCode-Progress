#!/bin/bash
# Script to update README.md with current statistics

echo "📊 Updating README.md with current statistics..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


# Get current values
TOTAL_SOLVED=$(grep -o '✅' PROGRESS.md | wc -l | tr -d ' ')
CURRENT_STREAK=$(python3 -c "import json; print(json.load(open('goals.json'))['streaks']['current'])" 2>/dev/null || echo "1")
CURRENT_DATE=$(date +%Y-%m-%d)

# Update HackerRank progress
PYTHON_HR_COMPLETED=$(grep -o '✅' PROGRESS.md | grep -c "Python.*HackerRank" || echo "0")
JAVA_HR_COMPLETED=$(grep -o '✅' PROGRESS.md | grep -c "Java.*HackerRank" || echo "0")  
C_HR_COMPLETED=$(grep -o '✅' PROGRESS.md | grep -c "C.*HackerRank" || echo "0")

# Update README.md
sed -i "s/Total Solved: [0-9]* problems/Total Solved: $TOTAL_SOLVED problems/g" README.md
sed -i "s/Current Streak: [0-9]* days/Current Streak: $CURRENT_STREAK days/g" README.md
sed -i "s/Last Updated: [0-9-]*/Last Updated: $CURRENT_DATE/g" README.md
sed -i "s/Python: [0-9]*\/100 problems/Python: $PYTHON_HR_COMPLETED\/100 problems/g" README.md
sed -i "s/Java: [0-9]*\/50 problems/Java: $JAVA_HR_COMPLETED\/50 problems/g" README.md
sed -i "s/C: [0-9]*\/30 problems/C: $C_HR_COMPLETED\/30 problems/g" README.md

echo "✅ README.md updated successfully!"
echo "📊 Total Solved: $TOTAL_SOLVED problems"
echo "🔥 Current Streak: $CURRENT_STREAK days"
echo "📅 Last Updated: $CURRENT_DATE"

# COUNT ACTUAL SOLUTIONS FROM FILESYSTEM
echo -e "${BLUE}📊 Counting actual solutions...${NC}"

# Count solutions from each language and platform
PYTHON_HR=$(find hackerrank/python -name "*.py" | wc -l)
JAVA_HR=$(find hackerrank/java -name "*.java" | wc -l)
C_HR=$(find hackerrank/c -name "*.c" | wc -l)

PYTHON_LC=$(find leetcode/python -name "*.py" | wc -l)
JAVA_LC=$(find leetcode/java -name "*.java" | wc -l)
C_LC=$(find leetcode/c -name "*.c" | wc -l)

# Calculate totals
PYTHON_TOTAL=$((PYTHON_HR + PYTHON_LC))
JAVA_TOTAL=$((JAVA_HR + JAVA_LC))
C_TOTAL=$((C_HR + C_LC))

# Update README.md with current values
echo -e "${BLUE}📝 Updating README content...${NC}"

# Update basic stats
sed -i "s/Last Updated: .*/Last Updated: $CURRENT_DATE/" README.md
sed -i "s/Total Coding Days: .*/Total Coding Days: $STREAK 🎯/" README.md
sed -i "s/Total Solved: .*/Total Solved: $TOTAL_SOLVED problems/" README.md

# Update HackerRank progress
sed -i "s/Python: [0-9]\\+/Python: $PYTHON_HR/" README.md
sed -i "s/Java: [0-9]\\+/Java: $JAVA_HR/" README.md
sed -i "s/C: [0-9]\\+/C: $C_HR/" README.md

# Update LeetCode progress  
sed -i "s/Python: [0-9]\\+\\/150/Python: $PYTHON_LC\\/150/" README.md
sed -i "s/Java: [0-9]\\+\\/100/Java: $JAVA_LC\\/100/" README.md
sed -i "s/C: [0-9]\\+\\/50/C: $C_LC\\/50/" README.md

echo -e "${GREEN}✅ README.md updated successfully!${NC}"
echo -e "📅 Date: $CURRENT_DATE"
echo -e "🔥 Streak: $STREAK days"
echo -e "📊 Total Solved: $TOTAL_SOLVED problems"
echo -e "🐍 Python Solutions: $PYTHON_TOTAL total ($PYTHON_HR HackerRank + $PYTHON_LC LeetCode)"
echo -e "☕ Java Solutions: $JAVA_TOTAL total ($JAVA_HR HackerRank + $JAVA_LC LeetCode)"
echo -e "🔧 C Solutions: $C_TOTAL total ($C_HR HackerRank + $C_LC LeetCode)"

