#!/usr/bin/env python3
"""
Generates progress statistics and visualizations
"""

import json
import matplotlib.pyplot as plt
from datetime import datetime

def generate_progress_chart():
    with open('../goals.json', 'r') as f:
        data = json.load(f)
    
    # Language progress chart
    languages = list(data['languages'].keys())
    progress = [data['languages'][lang]['progress'] for lang in languages]
    
    plt.figure(figsize=(10, 6))
    bars = plt.bar(languages, progress, color=['#ff6b6b', '#4ecdc4', '#45b7d1'])
    plt.title('Language Learning Progress')
    plt.ylabel('Completion (%)')
    plt.ylim(0, 100)
    
    for i, v in enumerate(progress):
        plt.text(i, v + 2, f'{v}%', ha='center', va='bottom', fontweight='bold')
    
    # Add some styling
    plt.grid(axis='y', alpha=0.3)
    plt.tight_layout()
    
    # Ensure docs directory exists
    import os
    os.makedirs('../docs', exist_ok=True)
    
    plt.savefig('../docs/progress-chart.png')
    plt.close()
    print("📈 Progress chart saved to docs/progress-chart.png")

def generate_weekly_report():
    with open('../goals.json', 'r') as f:
        data = json.load(f)
    
    report = f"""
# 📊 Weekly Progress Report
## Week Ending: {datetime.now().strftime('%Y-%m-%d')}

### 🎯 Overall Progress
- **Total Problems Solved:** {data['total_completed']}
- **Current Streak:** {data['streaks']['current']} days
- **Longest Streak:** {data['streaks']['longest']} days
- **Total Time Invested:** {data['metrics']['total_time']}

### 📈 Language Progress
"""
    
    for lang, stats in data['languages'].items():
        report += f"- **{lang.capitalize()}:** {stats['completed']}/{stats['goal']} ({stats['progress']}%)\n"
    
    report += f"""
### 🏆 Recent Activity
"""
    
    for activity in data['recent_activity'][:5]:
        report += f"- {activity['date']}: {activity['problem']} ({activity['language']}) - {activity['difficulty']} - {activity['time_taken']}\n"
    
    # Ensure docs directory exists
    import os
    os.makedirs('../docs', exist_ok=True)
    
    with open('../docs/weekly-report.md', 'w') as f:
        f.write(report)
    
    print("📋 Weekly report saved to docs/weekly-report.md")

if __name__ == "__main__":
    print("📊 Generating statistics...")
    generate_progress_chart()
    generate_weekly_report()
    print("✅ Statistics generated successfully!")