## Q2 : **Scenario**

Your internal web dashboard (hosted on `internal.example.com`) is suddenly unreachable from multiple systems. The service seems up, but users get “host not found” errors. You suspect a DNS or network misconfiguration. Your task is to troubleshoot, verify, and restore connectivity to the internal service.
  
**🛠️ Your Task:**
1.  Verify DNS Resolution:
Compare resolution from /etc/resolv.conf DNS vs. `8.8.8.8`.
2.  Diagnose Service Reachability:
Confirm whether the web service (port 80 or 443) is reachable on the resolved IP.
Use curl, telnet, netstat, or ss to find if the service is listening and responding.
3.  Trace the Issue – List All Possible Causes
**🧪** Your goal here is to identify and list all potential reasons why [internal.example.com](http://internal.example.com/) might be unreachable, even if the service is up and running. Consider both DNS and network/service layers.
4.  Propose and Apply Fixes
✅ For each potential issue you identified in Point 3, do the following:
1.  Explain how you would confirm it's the actual root cause
2.  Show the exact Linux command(s) you would use to fix it
  
**🧠** **Note:**
Please include screenshots that demonstrate how you identified and resolved the issue 
  
**🏆 Bonus:**
Configure a local /etc/hosts entry to bypass DNS for testing.
Show how to persist DNS server settings using systemd-resolved or NetworkManager.