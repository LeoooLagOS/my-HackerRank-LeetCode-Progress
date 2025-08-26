#!/bin/bash
# Auto-update progress script

echo "🔄 Updating progress..."
DATE=$(date +%Y-%m-%d)
PROBLEM=$1
LANGUAGE=$2
PLATFORM=$3

# Update PROGRESS.md
sed -i "s/| $(date +%a) | $LANGUAGE | $PROBLEM |.*|/| $(date +%a) | $LANGUAGE | $PROBLEM | $PLATFORM | ✅ |/" PROGRESS.md

# Update DAILY_LOG.md
echo "## $(date +%Y-%m-%d)" >> DAILY_LOG.md
echo "- ✅ Completed $LANGUAGE: $PROBLEM" >> DAILY_LOG.md

# Update goals.json
python3 -c "
import json
with open('goals.json', 'r') as f:
    data = json.load(f)
data['total_completed'] += 1
data['languages']['${LANGUAGE,,}']['completed'] += 1
data['current_streak'] += 1
with open('goals.json', 'w') as f:
    json.dump(data, f, indent=2)
"

git add .
git commit -m "progress: completed $LANGUAGE $PROBLEM"
git push origin main

echo "✅ Progress updated for $PROBLEM ($LANGUAGE)!"