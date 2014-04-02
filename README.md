# Pod Days

Nothing too special, just a ruby script to know what's changed in CocoaPods in the last `x days


### Usage

```
git clone [repourl]
bundle install
ruby days.rb 2
```

Will echo out all the updates in that time like so:

```
Pod: NBThemeConfig v1.0.0 by {"Josh Justice"=>"josh@need-bee.com"}
   - Configure all the colors for your app in a single plist.
   - {:git=>"https://github.com/needbee/nbthemeconfig.git", :tag=>"1.0.0"}

Pod: OBME v0.1.0 by {"Manu Mtz-Almeida"=>"manu.valladolid@gmail.com"}
   - Fast and easy to use tool in simple OBJECTIVE-C to avoid memory cheating by scanning (searching).
   - {:git=>"https://github.com/manucorporat/obme-ios.git", :tag=>"0.1.0”}
```

PRs welcome etc.