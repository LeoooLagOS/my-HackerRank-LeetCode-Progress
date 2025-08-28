#!/bin/bash
# Script to update dynamic content in README.md

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🔄 Updating README.md with current stats...${NC}"

# Navigate to root directory (in case script is run from elsewhere)
cd "$(dirname "$0")/.."

# Get current date
CURRENT_DATE=$(date +%Y-%m-%d)

# Get current streak from goals.json
if [ -f "goals.json" ]; then
    STREAK=$(python3 -c "
import json
import sys
try:
    with open('goals.json', 'r') as f:
        data = json.load(f)
    streak = data.get('streaks', {}).get('current', '2')
    print(streak)
except Exception as e:
    print('2')
    sys.exit(1)
" 2>/dev/null)
else
    STREAK="2"
fi

# Get total problems solved
if [ -f "goals.json" ]; then
    TOTAL_SOLVED=$(python3 -c "
import json
try:
    with open('goals.json', 'r') as f:
        data = json.load(f)
    total = data.get('total_completed', '3')
    print(total)
except:
    print('3')
" 2>/dev/null)
else
    TOTAL_SOLVED="3"
fi

# Update README.md with current values
sed -i "s/Last Updated: .*/Last Updated: $CURRENT_DATE/" README.md
sed -i "s/Total Coding Days: .*/Total Coding Days: $STREAK 🎯/" README.md
sed -i "s/Total Solved: .*/Total Solved: $TOTAL_SOLVED problems/" README.md

echo -e "${GREEN}✅ README.md updated successfully!${NC}"
echo -e "📅 Date: $CURRENT_DATE"
echo -e "🔥 Streak: $STREAK days"
echo -e "📊 Total Solved: $TOTAL_SOLVED problems"