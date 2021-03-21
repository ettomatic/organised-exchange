# Organised Exchange
Import Exchange `ics` calendars in Org Agenda.

## Rationale
In the last year my days have been bombarded with meetings. I wanted to keep track of them on my Org Agenda without the complexities of setting up an account using Davmail or similar solutions.

My check-list was:
- [x] Simple to setup
- [x] Meetings should nicely mix up with my normal schedules in Org Agenda
- [x] Read only, I can put a meeting in the calendar directly on Outlook
- [x] Show the Zoom link
- [x] Sync it manually or via cron

## Usage

Set envs vars:

```shell
$ env | grep ORGANISED_EXCHANGE
ORGANISED_EXCHANGE_ORIGIN=/location/for/your/calendar.ics
ORGANISED_EXCHANGE_DESTINATION=/target/org/file/exchange.org
```

Setup the Ruby dependencies
```shell
$ bundle install
```

Then you can simply run:

```
$ ruby bin/etoxchange_to_org
```

If you prefer you can use Docker
```shell
$ docker pull ettomatic/organised-exchange:latest
$ bin/eto
```

Or use an Emacs function like:

```emacs
(defun organised-exchange ()
  "Sync Outlook Calendar ics with Org Agenda."
  (interactive)
  (if (get-buffer "exchange.org")
      (kill-buffer "exchange.org"))
  (shell-command "~/code/organised-exchange/bin/eto")
  (message "calendar imported!"))
```


## Publishing your Exchange Calendar

In Order to have an up to date ics calendar from your Office 365 account you can:
1. Go to **Outlook Settings**
2. View all Outlook settings
3. the select **Calendar** on the left hand side
4. Select **Shared calendars**
5. Select and publish your calendar

:warning: This produces a link to your ics file, **be careful!** your calendar is now just [protected by obfuscation](https://support.microsoft.com/en-us/office/introduction-to-publishing-internet-calendars-a25e68d6-695a-41c6-a701-103d44ba151d), please consider if this is acceptable for your use case.

We are almost there! Just curl the ics file and import it in Emacs:
```
$ curl https://outlook.office365.com/owa/calendar/[....]/calendar.ics > $ORGANISED_EXCHANGE_ORIGIN
$ bin/exchange_to_org
```

Make sure your `org-agenda-files` includes the file you set for `$ORGANISED_EXCHANGE_DESTINATION` and Voila! Your Org Agenda will now show your Exchange meetings!

![Screenshot](img/org-agenda.png)

## Requirements

Ruby 2.x

## TODO

- [ ] Improve Sync from Emacs
- [ ] Timezones!
- [ ] A Docker image
- [ ] Make the Zoom link optional
- [ ] If there's interest make it more configurable


## Contributing

Want to help? Great!
1. Fork it (<https://github.com/ettomatic/organised-exchange/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
