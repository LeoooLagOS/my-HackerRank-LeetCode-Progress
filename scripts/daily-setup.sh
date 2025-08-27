#!/bin/bash
# daily-setup.sh - Prepares your daily coding environment

echo "🚀 Starting daily coding session..."
echo "📅 Date: $(date +%Y-%m-%d)"

# Navigate to main directory
cd ~/Documents/coding-practice/my-HackerRank-LeetCode-Progress/

# Open necessary files
code PROGRESS.md
code DAILY_LOG.md
code goals.json

# Show today's goals
echo "🎯 Today's Focus:"
grep -A 5 -B 5 "| $(date +%a) |" PROGRESS.md | head -10

# Show streak info
echo "🔥 Current Streak: $(python3 -c "import json; print(json.load(open('goals.json'))['streaks']['current'])" 2>/dev/null || echo "0") days"

# Open today's target language folder
TODAY=$(date +%a)
case $TODAY in
  "Mon"|"Wed")
    echo "🐍 Today is Python day!"
    code hackerrank/python/
    ;;
  "Tue"|"Thu")
    echo "☕ Today is Java day!"
    code hackerrank/java/
    ;;
  "Fri"|"Sat")
    echo "⚙️ Today is C day!"
    code hackerrank/c/
    ;;
  "Sun")
    echo "📊 Review day! Time to plan next week."
    code docs/
    ;;
esac

echo "✅ Daily setup complete! Happy coding! 🎉"