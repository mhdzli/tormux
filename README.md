# tormux
Tor in termux:

Install termux from [playstore](https://play.google.com/store/apps/details?id=com.termux) or [fdroid](https://f-droid.org/repo/com.termux).

Run these commands in termux:
```bash
$ curl -LO https://raw.githubusercontent.com/mhdzli/tormux/main/tormux.sh
$ bash tormux.sh install
$ tor &
```

Set socks proxy for telegram:

1. Go to settings > Data and Storage > Proxy Settings.
1. Tap on `Add Proxy`
1. Set the Server to `127.0.0.1` and port to `9050`


If Tor didn't connect to existing bridges:

1. Send an email with empty subjec field  and "get transport obfs4" in content to `bridges@torproject.org` to get new bridges (Just works with Gmail and Riseup). Alternatively you can get new bridges from [torproject website](https://bridges.torproject.org/options).
1. Replace exicting bridges in obfs.txt in downlods directory of your internal memory with new ones.
1. Run `bash tormux update` in `termux`
1. Run `tor &`

To stop tor just run `pkill tor` in `termux`

