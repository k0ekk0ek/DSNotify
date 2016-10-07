DSNotify
========
DSNotify implements a simple Python SMTP server to handle email notifications (asynchronously) from Download Station about finished tasks and execute a script for each one. This allows for event based handling of completed tasks without the need to modify any files shipped with Download Station itself or the need to update it's AppArmor configuration.

Installation
------------
1. Copy `dsnotify` to `/usr/local/sbin` on the Synology NAS

2. Create a Cron job to start the serice at boot time by editing `/etc/cronjobs` and adding the following content.
```
#minute hour    mday    month   wday    who     command
@reboot                                 root    /usr/local/bin/dsnotify -s SCRIPT -u USER -p PASSWORD
```

> DSNotify supports a number of other options too, run dsnotify -h for details

> Cron job *who* column must contain *root*, but you can drop privileges before executing the script by passing the command through */bin/su -c "/path/to/command" user*

E-mail notifications
--------------------
Enable E-mail notifications and configure notifications to be delivered to DSNotify.

1. Login to the device

2. Select **Notification** from the **Control Panel**

3. In the **Email** tab, check the box **Enable email notifications**

4. Select **Use custom email server** and select **Custom SMTP server**

5. Enter a dummy address for **Recipient's email address**

6. Enter the address and port for **SMTP server** and **SMTP port** respectively (*localhost* and *2525* by default)

Configure Download Station to send notifications on task completion.

1. Login to the device

2. Open the **Settings** screen in **Download Station**

3. In the **Settings** tab, check the box **Send email notification upon task completion**

4. Enter dummy data for both **From:** and **Recipients:**

