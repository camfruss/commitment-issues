# Commitment Issues?
Using GitHub's contribution heatmap for something else...

## Overview
On the rare occassions I duscuss coding with non-developers, their first instant is usually to ask about "size". Lines of code can be a meaninful metric — especially when starting new projects — but it favors commits over meaningful contributions. Yet, GitHub's contribution heatmap that lives on everyone's profile does little encourage quality over quantity...in fact, it encourages quantity above all else. As such, this project prevents an unreliable metric from being used.

Darker shades of green indicate a higher UV index in Boston, MA assuming clear sky conditions. The `init.sh` file assumes you do NOT have git setup on your machine...o.w. it is unncessary to run.  

## Getting Started

### Prereuisites

This is intended to run on MacOS. 

### Setup

After forking this repo, the setup just involves moving files around and adding permissions. 

```Bash
chmod +x commit.sh init.sh
cp com.camfruss.commit.plist ~/Library/LaunchAgents
launchctl load ~/Library/LaunchAgents/com.camfruss.commit.plist
```

If you are running this on a server, you can use `cronjob` instead. 

## TODO

- [ ] Account for "actual" commits

