# 🧠 KDE Dolphin Smart File Organizer

**Next-generation file management automation for KDE Plasma**

Instantly organize your files with AI-like intelligence - select files, right-click, and watch them automatically sort into intelligently named folders based on temporal analysis.

## ⚡ What It Does

This automation adds a **"Move to New Folder"** context menu option that:
- 🧠 **Smart Naming**: Analyzes file timestamps and names the folder after your **newest file**
- ⚡ **Instant Organization**: Moves multiple files in one click
- 🎯 **Zero Configuration**: Works immediately after installation

## 🛠️ Quick Setup

### 1. Install Files

```bash
# Make the script executable
chmod +x move_files_to_new.sh

# Move to your preferred location (example)
mkdir -p ~/Documents/automation/
mv move_files_to_new.sh ~/Documents/automation/
```

### 2. Update Script Path

Edit `move_files.desktop` and set the correct path:
```ini
Exec= ~/Documents/automation/move_files_to_new.sh %F # default in code
```

### 3. Install Service Menu

```bash
# Create the directory if it doesn't exist
mkdir -p ~/.local/share/kio/servicemenus/

# Install the service menu
cp move_files.desktop ~/.local/share/kio/servicemenus/
```

### 4. Refresh KDE Service Cache

Run the following command to refresh the KDE service cache:

```bash
kbuildsycoca5
```

## 🎮 How to Use

1. **Select** one or more files in Dolphin
2. **Right-click** → Choose "Move to New Folder"
3. **Done!** Files are now organized in a folder named after the **newest file**

## 📋 Example Workflow

**Before:**
```
Downloads/
├── old_document.pdf
├── budget_2025.xlsx
├── meeting_recording.mp4
└── latest_report.txt        (newest)
```

**After using "Move to New Folder":**
```
Downloads/
└── latest_report/           ← Named after newest file
    ├── old_document.pdf
    ├── budget_2025.xlsx
    ├── meeting_recording.mp4
    └── latest_report.txt
```

## 🔧 System Requirements

- **OS**: KDE Plasma 5/6
- **File Manager**: Dolphin
- **Shell**: Bash

## ⚠️ Safety Features

- **No Overwrites**: Aborts if target folder already exists
- **File Preservation**: Original timestamps and permissions maintained
- **Smart Detection**: Only processes regular files (ignores directories)

## 🔍 Technical Details

- **Algorithm**: Uses `mtime` (modification time) for temporal analysis
- **Naming Logic**: Strips file extensions for clean folder names
- **Integration**: Native KDE service menu system

## 📁 File Structure

```
automation/
├── move_files_to_new.sh       # Core automation script
└── README.md                   # Documentation

~/.local/share/kio/servicemenus/
└── move_files.desktop          # KDE service menu configuration
```

## 🚨 Troubleshooting

**Menu not appearing?**
- Verify `.desktop` file is in `~/.local/share/kio/servicemenus/`
- Run `kbuildsycoca5` to refresh cache
- Restart Dolphin: `killall dolphin && dolphin`

**Script not executing?**
- Check script permissions: `ls -la move_files_to_new.sh`
- Verify path in `.desktop` file is absolute
- Test manually: `./move_files_to_new.sh testfile.txt`

---

**⚡ Pro Tip**: This tool is perfect for organizing downloads, project files, or any batch of files that need logical grouping. The temporal analysis ensures your most recent (newest) file determines the folder name, keeping your latest work as the main identifier.
