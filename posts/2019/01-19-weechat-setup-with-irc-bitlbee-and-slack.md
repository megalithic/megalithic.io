%{
title: "Weechat Setup With IRC, Bitlbee And Slack",
tags: ["til", "weechat", "cli", "slack", "bitlbee", "dotfiles"],
description: """
Over the last several years, I've been using a consolidated online chat experience with weechat, a command-line interface IRC client that runs on all platforms (I'm specifically using it on macOS). I have it connected to my Digital Ocean droplet running bitlbee (for Google Hangouts) and ZNC (an IRC bouncer) and Slack (via wee-slack). I recently wiped my droplet and need to set all of that up again, so, I figured I'd take you along for the journey of installing all of the necessary tools and configuring everything.
"""
}

---

For the longest time, my [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet was used for random geeky things, such as a [ZNC IRC bouncer](https://wiki.znc.in/ZNC), [bitlbee](https://www.bitlbee.org), and a few other tools. Well, that changed when I decided to rebuild that droplet for bringing [megalithic industries](https://megalithic.io) to life. I decided to wipe the droplet clean, and start from scratch; in the process, I lost all of my configurations (yikes).

So, that just means I have blog post content now; all in an effort to help others wanting to set up a modern day [weechat](https://weechat.org) command-line chat interface (complete with a ZNC server, bitlbee, and [wee-slack](https://github.com/wee-slack/wee-slack)).

By the end of this post, you'll have a fully working weechat CLI interface setup on your local machine, that will give you the ability to hook into IRC (via your own ZNC IRC bouncer), [bitlbee](https://www.bitlbee.org) (for Google Hangouts, amongst other services), and finally, [wee-slack](https://github.com/wee-slack/wee-slack) (a great python script that allows for communications with Slack's websockets API).

This article assumes that you have already [setup and secured](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04) a [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet.

## ZNC

Let's install [ZNC](https://wiki.znc.in/ZNC) and setup a user to run ZNC under. This also generates a config file for you. It will walk you through some defaults, and let you fill in important details. As part of those details, let's go ahead and setup [freenode](https://freenode.net) as our initial IRC server, and remember the port you set for ZNC (we'll assume `5000`).

#### Installation

```bash
cd ~
sudo apt install -y znc znc-dev
sudo useradd --create-home -d /var/lib/znc --system --shell /sbin/nologin --comment "User to run ZNC daemon" --user-group znc
sudo -u znc /usr/bin/znc --datadir=/var/lib/znc --makeconf
```

Before we continue with setting up ZNC configs, let's make sure it auto-launches anytime our droplet restarts..

First, create a systemd service: `sudo vim /etc/systemd/system/znc.service`

Use the following service config:

```ini
[Unit]
Description=ZNC Service
After=network-online.target

[Service]
ExecStart=/usr/bin/znc -f --datadir=/var/lib/znc
User=znc

[Install]
WantedBy=multi-user.target
```

Reload the daemon and enable ZNC service

```bash
sudo systemctl daemon-reload
sudo systemctl enable znc
```

#### Configuration

With installation done we need to setup our main ZNC user and all of its config.

First, let's try visiting the ZNC web config panel at `http://<droplet_ip>:5000`.

From here you should be able to log in with the user and password you defined during initial ZNC setup.

Next, you'll want to click the "Your Settings" link from the web interface. You can now easily change the password if you want, along with all the other settings for Freenode, including setting up the channels to always connect to. You can also setup `nickserv` module to automatically identify you and your preferred nick. Dope!

#### Weechat

Last thing to do is setup weechat to connect to your ZNC server for all your IRC needs!

We're going to assume you already have weechat installed on your OS of choice (for macOS: `brew install weechat`).

From within weechat, we're going to add a server for freenode, and set it up to auto-connect for us..

```
/server add freenode <droplet_ip>/<port_for_znc> -autoconnect
/connect freenode
/save
```

Assuming you setup the `nickserv` module in ZNC, as well as some initial channels to connect to, it should just auto-connect and auto-join freenode and those channels. We're done with ZNC/IRC.

## Bitlbee

Now that we have IRC things taken care of with ZNC, let's install [bitlbee](https://www.bitlbee.org) and libpurple so that we can get Google Hangouts working with weechat. We'll need to use Mercurial for version control for connecting the dots between libpurple and hangouts. Finally, we'll build the [purple-hangouts](https://bitbucket.org/EionRobb/purple-hangouts/overview) project.

#### Installation

```bash
cd ~
sudo mkdir -p /var/lib/bitlbee
sudo apt-get install -y python-pip python-potr bitlbee-common bitlbee-libpurple bitlbee-plugin-otr libpurple-dev libjson-glib-dev libglib2.0-dev libprotobuf-c-dev protobuf-c-compiler mercurial make
mkdir src
cd src
hg clone https://bitbucket.org/EionRobb/purple-hangouts/ && cd purple-hangouts;
make && sudo make install
```

Before we get to configuring bitlbee further, let's make sure it relaunches upon restarting our droplet.

First, create a systemd service: `sudo vim /lib/systemd/system/bitlbee.service`

Use the following service config:

```ini
[Unit]
Description=BitlBee IRC/IM gateway

[Service]
ExecStart=/usr/sbin/bitlbee -F -n
KillMode=process

[Install]
WantedBy=multi-user.target
```

Reload the daemon and enable bitlbee service

```bash
sudo systemctl daemon-reload
sudo systemctl enable bitlbee
```

#### Configuration

Ok, let's quickly configure our bitlbee instance: `sudo vim /etc/bitlbee/bitlbee.conf`

I prefer these settings:

```ini
[settings]
RunMode = ForkDaemon
User = bitlbee
DaemonInterface = 0.0.0.0
DaemonPort = 5001
AuthMode = Open
[defaults]
```

#### Weechat

Configuration of bitlbee and purple-hangouts should be done, so now we just need to connect it up to weechat. We're going to assume you already have weechat installed on your OS of choice (for macOS: `brew install weechat`).

We'll setup a hangouts server (could be called anything you want). Next we'll connect to it, then we'll register a super_secret_password. Lastly we'll setup weechat to auto log us in each time.

```
/server add hangouts <droplet_ip>/<port_for_bitlbee> -autoconnect
/connect hangouts
register <super_secret_password>
/set irc.server.hangouts.command "/msg &bitlbee /OPER identify <super_secret_password>"
/save
```

Now we need to setup Google Hangouts for bitlbee/purple. Let's do that now, while we have the &bitlbee buffer selected in weechat.

```
acc add hangouts your-gmail-account@gmail.com
acc hangouts on
```

You'll be presented with a private message from `purple_request_0`. It prompts you to visit a YouTube video to watch to get the `oauth_code` to respond with in the PM. Once you enter the oauth_code, you're done, it'll connect you.

Lastly we need to save our configs in weechat/bitlbee!

For bitlbee, while you're still in the bitlbee buffer: `save`

For weechat, from any buffer: `/save`

## Slack

The best way to connect to your various [Slack](https://slack.com/) groups is with a python weechat plugin called wee-slack. It supports real-time chat via websockets. This means that you will get a TON of amazing features like, typing notifications, emoji reaction support, interacting with your status, threads, and [so much more](https://github.com/wee-slack/wee-slack#features).

Let's get that all setup!

#### Installation

wee-slack has one system dependency, that is the python websocket pip plugin, to install on macOS: `pip install websocket-client`.

Now that our dependency is installed, let's get wee-slack installed, and symlinked to autoload when weechat starts up:

```bash
cd ~/.weechat/python
wget https://raw.githubusercontent.com/wee-slack/wee-slack/master/wee_slack.py
ln -sfv ../wee_slack.py autoload
```

#### Configuration

As to not take away from the tireless work and documentation from the wee-slack contributors, I'm going to link you to their setup section for getting your [Slack API token's created and stored in weechat](https://github.com/wee-slack/wee-slack#4-add-your-slack-api-keys).

After you complete the API token creation and registration processes linked above, you'll want to be sure to `/save` within weechat to save all of this configuration.

## Fin

That does it folks!

You now have a working ZNC IRC bouncer, and bitlbee server setup on your own [Digital Ocean](https://m.do.co/c/6abe22c9c487) droplet. You also now have weechat setup on your local machine, complete with connectivity to IRC freenode via ZNC, Google Hangouts via bitlbee, and to Slack via wee-slack.

If you'd like to check out a fully working weechat setup, feel free to [peruse my dotfiles](https://github.com/megalithic/dotfiles/tree/master/weechat). This is setup for my purposes, but should give a really good idea as to what all is possible.

Happy CLI chatting!

### Links

- [Digital Ocean](https://m.do.co/c/6abe22c9c487)
- [Initial droplet setup for Ubuntu 18.04](https://www.digitalocean.com/community/tutorials/initial-server-setup-with-ubuntu-18-04)
- [Weechat](https://weechat.org)
- [ZNC](https://wiki.znc.in/ZNC)
- [Freenode](https://freenode.net)
- [Bitlbee](https://bitlbee.org)
- [purple-hangouts](https://bitbucket.org/EionRobb/purple-hangouts/overview)
- [wee-slack](https://github.com/wee-slack/wee-slack)
- [Slack](https://slack.com)
- [My dotfiles](https://github.com/megalithic/dotfiles/tree/master/weechat)
