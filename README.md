# TrollCuts
Shortcuts extensions for iOS 16.0+. It leverages the ability of [TrollStore](https://github.com/opa334/TrollStore) to obtain arbitraty entitlements for binary and thus doing stuffs that normally sandboxed apps unable to. 

I created this because I needed an automatable way to switch TrollStore installed apps registration state so that iCloud could backup them. I never tested the theory what happens when automatic backup happens in the middle of the night when those apps are in "System" state. Will the previously backed-up data dissappear again? Guess only one way to find out. 

It only comes with few basic Shortcuts extensions (because I just realized how much I dislikes Swift). If you got interesting stuffs to extend its extensions functionality, do it.

# Requirements
iOS 16.0+ (AppIntents framework) and [TrollStore](https://github.com/opa334/TrollStore).

# Credits
[TrollStore](https://github.com/opa334/TrollStore) - chunks of code in this repository are from there

[PureKFD](https://github.com/PureKFD/PureKFD) - for the `userspacereboot.c`

# License
Pieces of code obtained from other repo are bound to their own license, everything else do as you please.
