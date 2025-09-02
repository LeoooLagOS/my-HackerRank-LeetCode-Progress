#!/bin/bash
# Script to update README.md with current statistics

echo "📊 Updating README.md with current statistics..."

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
