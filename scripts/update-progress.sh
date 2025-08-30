#!/bin/bash
# Enhanced progress tracking with better error handling and metrics

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo -e "${GREEN}Usage: ./update-progress.sh \"Problem Name\" \"Language\" \"Platform\" \"Difficulty\" \"Time Taken\"${NC}"
    echo -e "${BLUE}Example: ./update-progress.sh \"Arithmetic Operators\" \"Python\" \"HackerRank\" \"Easy\" \"15m\"${NC}"
    echo -e "${YELLOW}Note: Difficulty and Time are optional${NC}"
}

# Validate input
if [ $# -lt 3 ]; then
    echo -e "${RED}❌ Error: Missing required parameters${NC}"
    usage
    exit 1
fi

PROBLEM_NAME=$1
LANGUAGE=$2
PLATFORM=$3
DIFFICULTY=${4:-"Unknown"}
TIME_TAKEN=${5:-"0m"}

echo -e "${GREEN}========================================${NC}"
echo -e "${YELLOW}🔄 Updating progress for $LANGUAGE: $PROBLEM_NAME...${NC}"
echo -e "${BLUE}📊 Difficulty: $DIFFICULTY | ⏱️ Time: $TIME_TAKEN${NC}"
echo -e "${GREEN}========================================${NC}"

# Get current date info
CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_DAY=$(date +%a)
CURRENT_TIME=$(date +%H:%M:%S)

# Navigate to root directory
cd "$(dirname "$0")/.."

# Check if PROGRESS.md exists
if [ ! -f "PROGRESS.md" ]; then
    echo -e "${RED}❌ Error: PROGRESS.md not found${NC}"
    exit 1
fi

# Update PROGRESS.md
if grep -q "| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME |" PROGRESS.md; then
    # Create solution file path
    SOLUTION_FILE="${LANGUAGE,,}/${PROBLEM_NAME// /-}.${LANGUAGE,,}"
    sed -i "s/| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME |.*|/| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME | $PLATFORM | $DIFFICULTY | ✅ | [$TIME_Taken](./$SOLUTION_FILE) |/" PROGRESS.md
    echo -e "${GREEN}✅ Updated PROGRESS.md${NC}"
else
    echo -e "${RED}❌ Error: Problem '$PROBLEM_NAME' not found in progress table for $CURRENT_DAY${NC}"
    echo -e "${YELLOW}💡 Please add it to PROGRESS.md first or check the spelling${NC}"
    exit 1
fi

# Update DAILY_LOG.md
if ! grep -q "## $CURRENT_DATE" DAILY_LOG.md; then
    echo -e "\n## $CURRENT_DATE" >> DAILY_LOG.md
    echo "- 📅 **Daily Summary**" >> DAILY_LOG.md
    echo -e "${GREEN}📝 Created new daily log entry${NC}"
fi

echo "- ✅ **[$(date +%H:%M)]** Completed $LANGUAGE: **$PROBLEM_NAME** ($DIFFICULTY) - Time: $TIME_TAKEN" >> DAILY_LOG.md
echo -e "${GREEN}📝 Updated DAILY_LOG.md${NC}"

# Update goals.json with Python
echo -e "${YELLOW}📈 Updating goals and metrics...${NC}"
python3 << EOF
import json
from datetime import datetime

try:
    with open('goals.json', 'r') as f:
        data = json.load(f)
except FileNotFoundError:
    print("Error: goals.json not found")
    exit(1)

# Update basic counters
data['total_completed'] = data.get('total_completed', 0) + 1
data['languages']['${LANGUAGE,,}']['completed'] = data['languages']['${LANGUAGE,,}'].get('completed', 0) + 1
data['platforms']['${PLATFORM,,}']['completed'] = data['platforms']['${PLATFORM,,}'].get('completed', 0) + 1

# Calculate progress percentages
for lang in data['languages']:
    completed = data['languages'][lang].get('completed', 0)
    goal = data['languages'][lang].get('goal', 1)  # Avoid division by zero
    data['languages'][lang]['progress'] = round((completed / goal) * 100, 1) if goal > 0 else 0

# Streak tracking
today = datetime.now().strftime('%Y-%m-%d')
if data.get('last_activity') != today:
    data['current_streak'] = data.get('current_streak', 0) + 1
    data['last_activity'] = today
    if data['current_streak'] > data.get('longest_streak', 0):
        data['longest_streak'] = data['current_streak']

# Add to recent activity
if 'recent_activity' not in data:
    data['recent_activity'] = []
    
data['recent_activity'].insert(0, {
    'date': today,
    'time': '$CURRENT_TIME',
    'problem': '$PROBLEM_NAME',
    'language': '$LANGUAGE',
    'platform': '$PLATFORM',
    'difficulty': '$DIFFICULTY',
    'time_taken': '$TIME_TAKEN'
})

# Keep only last 15 activities
data['recent_activity'] = data['recent_activity'][:15]

# Update metrics
data['metrics'] = data.get('metrics', {})
data['metrics']['total_time'] = data['metrics'].get('total_time', '0m')
data['metrics']['last_updated'] = '$CURRENT_DATE $CURRENT_TIME'

with open('goals.json', 'w') as f:
    json.dump(data, f, indent=2)
EOF

echo -e "${GREEN}✅ Updated goals.json${NC}"

# Update README with current stats
echo -e "${YELLOW}📊 Updating README.md with current stats...${NC}"
./scripts/update-readme.sh

# Git operations
echo -e "${YELLOW}🔗 Updating GitHub repository...${NC}"
git add .
git commit -m "progress: completed $LANGUAGE - $PROBLEM_NAME ($DIFFICULTY) in $TIME_TAKEN"

# Try to push, but don't fail if there are network issues
if git push origin main; then
    echo -e "${GREEN}✅ Pushed to GitHub${NC}"
else
    echo -e "${YELLOW}⚠️  Could not push to GitHub (network issue?), changes committed locally${NC}"
fi

# Success message with summary
completed_count=$(grep -o '✅' PROGRESS.md | wc -l | tr -d ' ')
current_streak=$(python3 -c "import json; print(json.load(open('goals.json'))['streaks']['current'])" 2>/dev/null || echo "0")

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}🎉 Progress updated for $PROBLEM_NAME ($LANGUAGE)!${NC}"
echo -e "${BLUE}📊 Total completed: $completed_count problems${NC}"
echo -e "${BLUE}🔥 Current streak: $current_streak days${NC}"
echo -e "${GREEN}========================================${NC}"

# Show motivational message based on time taken
if [ "$TIME_TAKEN" != "0m" ]; then
    if [[ "$TIME_TAKEN" == *"m"* ]] && [ "${TIME_TAKEN%m*}" -lt 10 ]; then
        echo -e "${GREEN}⚡ Wow! You solved that quickly! Amazing job! 🚀${NC}"
    elif [[ "$TIME_TAKEN" == *"h"* ]]; then
        echo -e "${YELLOW}💪 Persistence pays off! Great dedication! 🌟${NC}"
    else
        echo -e "${BLUE}👍 Solid work! Keep that momentum going! 📈${NC}"
    fi
fi

echo -e "${GREEN}========================================${NC}"