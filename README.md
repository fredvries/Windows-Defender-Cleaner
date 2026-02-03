Windows Defender Cleaner

Windows Defender is Microsoft's antivirus built into your Windows PC to protect you from viruses, malware threats, and attacks. It stores its info in several logs.

[1] Windows Defender Security Log<BR>
Whenever the Windows Defender runs a scan on your computer, it automatically stores the protection history in the Windows Defender Security Log. It also includes Controlled Folder Access blocks, along with any blocks which were made through the organizational configuration of Attack Surface Reduction Rules.

Though Protection History gets deleted after some time, the Windows Defender Security Log can become quite large, especially after an infection. Besides, the data stored in it may itself be used to see what sort of browsing history you have, which constitutes a breach of your privacy.

[2] Windows Health Center or WHC log<BR>
This log is used by Defender to report status and health information to the Windows operating system (e.g., whether real-time protection is enabled, if the product is up to date, or overall security health state). 

[3] Windows Defender Protection History log<BR>
Windows Defender Protection History displays recent actions, such as blocked threats and completed scans. It retains events for two weeks, showing critical (red) or informational (yellow) items that can be filtered to manage quarantined files. Events are automatically removed after two weeks. This log can be safely removed.

[4] MpCmdRun.log
MpCmdRun.log is a temporary diagnostic log file created by Microsoft Defender Antivirus (Windows Defender). It records activity from the command-line utility MpCmdRun.exe, such as manual scans, signature updates forced via command line, troubleshooting runs, or certain automated operations. This log can be safely cleaned, since Defender recreates/re-populates it as new events occur.

Instructions:<BR>
- Download the batchfile to your Desktop
- Run as an Administrator (Right-click > 'Run as admin')

Changelog:<BR>
- [03feb26] version 1.5: Added cleaning of MpCmdRun.log
- [26jan26] version 1.4: Added removal of Windows Defender Protection History log
- [24jan26] version 1.3: Added better log to show how much is cleaned
- [18jan26] version 1.2: Added cleaning of WHC log
- [15dec25] version 1.1: Added log to show how much is cleaned
- [15dec25] version 1.0: Initial release 
