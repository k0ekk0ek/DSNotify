DSNotify
========
DSNotify implements a simple Python SMTP server to handle email notifications (asynchronously) from Download Station about finished tasks and execute a script for each one. This allows for event based handling of completed tasks without the need to modify any files shipped with Download Station itself or the need to update it's AppArmor configuration.

Installation
------------
1. Copy `dsnotify` to `/usr/local/bin/dsnotify`

2. Change `dsnotify` mode to `0755`

3. Copy `dsnotify.sh` to `/usr/local/etc/rc.d/dsnotify.sh`, to ensure the service is started at boot time (only files with the .sh extension are executed)

4. Change `dsnotify.sh` mode to `0755` (only files with mode *0755* are executed)

5. Copy `dsnotify.conf` to `/usr/local/etc/dsnotify/dsnotify.conf`

6. Create `/usr/local/etc/dsnotify/dsnotify.passwd` and place

7. Change `dsnotify.passwd` mode to `0400`

8. Update configuration settings in `dsnotify.conf` to suit your environment

9. Start DSNotify by executing `/usr/local/etc/rc.d/dsnotify.sh start`

> DSNotify supports a number of other options too, run dsnotify -h for details. Update `dsnotify.sh` and `dsnotify.conf` accordingly to make DSNotify use your preferences on startup.

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

