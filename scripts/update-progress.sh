#!/bin/bash
# Enhanced progress tracking with better error handling and metrics

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo "Usage: ./update-progress.sh \"Problem Name\" \"Language\" \"Platform\" \"Difficulty\" \"Time Taken\""
    echo "Example: ./update-progress.sh \"Arithmetic Operators\" \"Python\" \"HackerRank\" \"Easy\" \"15m\""
}

# Validate input
if [ $# -lt 3 ]; then
    echo -e "${RED}Error: Missing parameters${NC}"
    usage
    exit 1
fi

PROBLEM_NAME=$1
LANGUAGE=$2
PLATFORM=$3
DIFFICULTY=${4:-"Unknown"}
TIME_TAKEN=${5:-"0m"}

echo -e "${YELLOW}🔄 Updating progress for $LANGUAGE: $PROBLEM_NAME...${NC}"

# Get current date info
CURRENT_DATE=$(date +%Y-%m-%d)
CURRENT_DAY=$(date +%a)

# Update PROGRESS.md
if grep -q "| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME |" ../PROGRESS.md; then
    sed -i "s/| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME |.*|/| $CURRENT_DAY | $LANGUAGE | $PROBLEM_NAME | $PLATFORM | $DIFFICULTY | ✅ | [$TIME_TAKEN](../hackerrank\/${LANGUAGE,,}\/${PROBLEM_NAME// /-}.${LANGUAGE,,}) |/" ../PROGRESS.md
else
    echo -e "${RED}Error: Problem not found in progress table for today${NC}"
    echo "Please add it to PROGRESS.md first"
    exit 1
fi

# Update DAILY_LOG.md
if ! grep -q "## $CURRENT_DATE" ../DAILY_LOG.md; then
    echo -e "\n## $CURRENT_DATE" >> ../DAILY_LOG.md
    echo "- 📅 **Daily Summary**" >> ../DAILY_LOG.md
fi
echo "- ✅ Completed $LANGUAGE: **$PROBLEM_NAME** ($DIFFICULTY) - Time: $TIME_TAKEN" >> ../DAILY_LOG.md

# Update goals.json with Python
python3 << EOF
import json
from datetime import datetime

with open('../goals.json', 'r') as f:
    data = json.load(f)

# Update basic counters
data['total_completed'] += 1
data['languages']['${LANGUAGE,,}']['completed'] += 1
data['platforms']['${PLATFORM,,}']['completed'] += 1

# Calculate progress percentages
for lang in data['languages']:
    completed = data['languages'][lang]['completed']
    goal = data['languages'][lang]['goal']
    data['languages'][lang]['progress'] = round((completed / goal) * 100, 1)

# Streak tracking
today = datetime.now().strftime('%Y-%m-%d')
if data.get('last_activity') != today:
    data['current_streak'] += 1
    data['last_activity'] = today
    if data['current_streak'] > data['longest_streak']:
        data['longest_streak'] = data['current_streak']

# Add to recent activity
if 'recent_activity' not in data:
    data['recent_activity'] = []
data['recent_activity'].insert(0, {
    'date': today,
    'problem': '$PROBLEM_NAME',
    'language': '$LANGUAGE',
    'platform': '$PLATFORM',
    'difficulty': '$DIFFICULTY',
    'time_taken': '$TIME_TAKEN'
})
# Keep only last 10 activities
data['recent_activity'] = data['recent_activity'][:10]

with open('../goals.json', 'w') as f:
    json.dump(data, f, indent=2)
EOF

# Git operations
cd ..
git add .
git commit -m "progress: completed $LANGUAGE - $PROBLEM_NAME ($DIFFICULTY)"
git push origin main

echo -e "${GREEN}✅ Progress updated for $PROBLEM_NAME ($LANGUAGE)!${NC}"
completed_count=$(grep -o '✅' PROGRESS.md | wc -l)
echo -e "📊 Total completed: $completed_count"