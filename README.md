# OSRS Anti-Idle

A smart AutoHotkey script that prevents Old School RuneScape (OSRS) from logging you out due to inactivity. Works with multiple game clients simultaneously and verifies the correct window before sending input.

## ⚠️ Important Disclaimer

**Use at your own risk.** This script interacts with the OSRS client, which may violate Jagex's Terms of Service. This tool is provided for educational purposes only. The author assumes no responsibility for any account actions taken by Jagex.

## 📋 Requirements

- **Windows PC**
- **AutoHotkey v1.1** (download: https://www.autohotkey.com/)
- **Old School RuneScape** (RuneLite, HDOS, or Official Client)

## 🚀 Installation & Usage

1. **Download and install AutoHotkey** from the official website
2. **Download** `anti-idle.ahk` from this repository
3. **Right-click** the file and select **"Edit"** (to customize your window names)
4. **Save** the file after making your changes
5. **Double-click** the file to run it
6. **Look for the green "H" icon** in your system tray (bottom-right corner)

## 🛠️ Customization Guide (No Coding Needed!)

### Step 1: Set Your Window Names

Open the script in any text editor (Notepad works fine). Find this section:

```autohotkey
scanWindows() {
	scanWindowToSend("Account name1", 1)
	scanWindowToSend("Account name2", 2)
	scanWindowToSend("Account name3", 3)
	scanWindowToSend("Account name4", 4)
	scanWindowToSend("Account name5", 5)
}
```

**Change the names in quotes** to match your OSRS window titles.

**How to find your window title:**
1. Open your OSRS client
2. Look at the **top bar** of the window
3. RuneLite usually shows: `RuneLite - YourUsername`
4. Official client shows: `Old School RuneScape`

**Example customization:**
```autohotkey
scanWindows() {
	scanWindowToSend("RuneLite - MainAccount", 1)
	scanWindowToSend("RuneLite - AltAccount1", 2)
	scanWindowToSend("RuneLite - AltAccount2", 3)
	scanWindowToSend("RuneLite - AltAccount3", 4)
	scanWindowToSend("RuneLite - AltAccount4", 5)
}
```

### Step 2: Adjust the Timing

Find this line near the top:
```autohotkey
secondsBetweenSends := 30
```

This means the script sends a key every **30 seconds**.

**To change it:**
- `secondsBetweenSends := 60` = every 1 minute
- `secondsBetweenSends := 120` = every 2 minutes
- `secondsBetweenSends := 300` = every 5 minutes

⚠️ **Warning:** OSRS logs you out after 5 minutes (300 seconds) of inactivity. Don't set this higher than 280 to be safe.

### Step 3: Add More Accounts

You can monitor up to 7 accounts by default. To add more:

1. **Copy an existing line** in the `scanWindows()` section
2. **Change the name** in quotes
3. **Use the next number** (6, 7, etc.)

**Example adding a 6th account:**
```autohotkey
scanWindows() {
	scanWindowToSend("Account name1", 1)
	scanWindowToSend("Account name2", 2)
	scanWindowToSend("Account name3", 3)
	scanWindowToSend("Account name4", 4)
	scanWindowToSend("Account name5", 5)
	scanWindowToSend("RuneLite - NewAccount", 6)  <-- Added this line
}
```

**To remove accounts:** Simply delete the line for that account.

### Step 4: Change the Key Being Pressed

Find this line inside the script:
```autohotkey
Send, {BackSpace}
```
You can change `{BackSpace}` to:
- `{Space}` - Spacebar
- `{Enter}` - Enter key
- `a` - Letter A
- `1` - Number 1
- `{F1}` - F1 key
- `{Esc}` - Escape key

## 🛑 How to Stop the Script

**Method 1:** Right-click the green "H" icon in your system tray → Click **"Exit"**

**Method 2:** Press **Ctrl + Alt + Delete** → Open Task Manager → Find "AutoHotkey" → Click **"End Task"**

## ❓ Troubleshooting

### "The script says it can't find my window"
- Make sure the window title matches **exactly** (capitalization matters!)
- Try using just part of the title. For example, if the window is "RuneLite - Zezima", you can use just `"RuneLite"` or `"Zezima"`
- Make sure the OSRS window is not minimized

### "It's sending keys to the wrong window"
- This script has built-in protection! It checks for a specific purple color (0x8A4BA9) that appears in OSRS interfaces
- Make sure the OSRS window is visible on screen and not covered by other windows
- The script verifies the window handle to ensure it's targeting the correct client

### "I'm still getting logged out"
- Decrease `secondsBetweenSends` to `20` or `25`
- Make sure the script is actually running (check for the green "H" icon)
- Ensure the OSRS window is not minimized (the script needs to see the window)

### "The script crashes or shows an error"
- Make sure you have **AutoHotkey v1.1** installed (not v2.0)
- Check that you didn't accidentally delete any brackets `{}` or parentheses `()`

## 🔧 How It Works (Technical Details)

1. **Scans every second** for your specified window titles
2. **Searches for purple pixels** (0x8A4BA9) within the window area — this color appears in OSRS interfaces
3. **Verifies the window handle** to ensure it's targeting the exact right window
4. **Activates the window** and sends a Backspace key
5. **Waits 30 seconds** (or your custom time) before repeating

The purple color check prevents the script from accidentally interacting with other windows that might have similar titles.
