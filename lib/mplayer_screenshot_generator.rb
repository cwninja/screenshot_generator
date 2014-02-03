require "mplayer_screenshot_generator/version"

class MplayerScreenshotGenerator
  # Helper method for fetching a single frame
  def self.extract_frame(video, *args)
    new(video).extract_frame(*args)
  end

  def self.extract_multi(video, *args)
    new(video).extract_multi(*args)
  end

  def initialize(video, size: '640x400')
    @video = video
    @size = size
  end

  attr_reader :video, :size

  def extract_multi(path, count)
    0.upto(count) do |index|
      path = Pathname.new(path) + "#{index}.jpg"
      segment_size = get_length(video) / (count + 2)
      offset = (index + 1) * segment_size
      extract_frame(video, offset, path)
    end
  end

  def length
    @length ||= get_length
  end

  def extract_frame(offset, path)
    offset = format_offset(offset)
    ffmpeg(
      "-loglevel", "error",
      "-ss", offset,
      "-i", video,
      "-frames:v", 1,
      "-s", size,
      path
    )
  end

protected

  def ffmpeg(*args)
    options = [self.class.ffmpeg, *args].map(&:to_s)
    options.push(:err=>[:child, :out])
    IO.popen(options) {|io| return io.read }
  end

  def self.ffmpeg
    @ffmpeg ||= `which ffmpeg`.chomp
  end

  def get_length(video)
    output = ffmpeg("-i", video, "-frames", 1)
    if output =~ /Duration:\s*([0-9:.]+)/
      h,m,s = $1.split(":").map(&:to_i)
      h*60^2 + m*60 + s
    else
      60
    end
  end

  def format_offset(v)
    m, s = v.divmod(60)
    h, m = m.divmod(60)
    "%02i:%02i:%02i" % [h, m, s]
  end
end
