# ScreenshotGenerator

It makes pictures of your videos using ffmpg, and ruby.

## Installation
```bash
gem install screenshot_generator
```

## Usage
```ruby
# Capture that lovely view from 3 hours into your 6 hour holiday video.
ScreenshotGenerator.extract_frame("holiday.mp4", 60*60*3, "the-car-park.jpg")

# Take 20 frames spread evenly around your holiday video, so you can sample the
# majesty of the same beach, from 20 different angles.
ScreenshotGenerator.extract_multi("holiday.mp4", "pictures-for-firends/", 20)

# Capture the three interesting bits of your holiday video.
vid = ScreenshotGenerator.new("holiday.mp4")
vid.extract_frame(60*60*2+8, "base-jumping.jpg")
vid.extract_frame(vid.length - 30, "end-credits.jpg")
```

## Additional usage
Although not thoroughly tested, it is theoretically possible that this library
could be used to take screen shots of videos that are neither holiday related,
nor dull.

## Licence
WTFBPPL: http://tomlea.co.uk/WTFBPPL.txt

