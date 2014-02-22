require "rubygems"
require "bundler"
Bundler.setup

require "screenshot_generator"
require "rspec"

require "chunky_png"

describe ScreenshotGenerator do
  let(:test_video){ "spec/fixtures/test-video.mov" }
  let(:tmpfile){ "tmp/test_frame.png" }

  describe ".extract_frame" do
    it "extracts a frame from the video" do
      expect(color_for_frame(0)).to be :red
      expect(color_for_frame(1)).to be :green
      expect(color_for_frame(2)).to be :blue
    end

    it "raises an ArgumentError if the video does not exist" do
      expect{
        ScreenshotGenerator.extract_frame("/tmp/does-not-exist.mp4", 0, "/dev/null")
      }.to raise_error ArgumentError
    end

    it "errors is the output file already exists" do
      expect{
        ScreenshotGenerator.extract_frame(test_video, 0, __FILE__)
      }.to raise_error ArgumentError
    end
  end

  describe "#length" do
    it "knows how long the video is" do
      expect(ScreenshotGenerator.new(test_video).length).to eq 18
    end
  end

  describe ".extract_multi" do
    it "calls extract_frame for each needed frame" do
      in_a_temp_dir do |dir|
        ScreenshotGenerator.extract_multi(test_video, dir, 5)
        0.upto(5) do |i|
          %x{convert #{dir + "#{i}.jpg"} #{dir + "#{i}.png"}} 
        end
        expect(color_for_image(dir + "0.png")).to be :blue
        expect(color_for_image(dir + "1.png")).to be :black
        expect(color_for_image(dir + "2.png")).to be :green
        expect(color_for_image(dir + "3.png")).to be :white
        expect(color_for_image(dir + "4.png")).to be :red
        expect(color_for_image(dir + "5.png")).to be :blue
      end
    end
  end

  def color_for_image(path)
    rgb(ChunkyPNG::Image.from_file(path)[50,50]).classify
  end

  def color_for_frame(i)
    ScreenshotGenerator.extract_frame(test_video, i, tmpfile)
    color_for_image(tmpfile)
  ensure
    File.unlink tmpfile if File.exists?(tmpfile)
  end

  def in_a_temp_dir
    dir = Pathname.new("tmp/working")
    FileUtils.mkdir_p dir
    yield dir
  ensure
    FileUtils.rm_r dir
  end

  Color = Struct.new(:r, :g, :b) do
    def classify
      if r > 250 and g > 250 and b > 250
        :white
      elsif r < 5 and g > 250 and b < 5
        :green
      elsif r > 250 and g < 5 and b < 5
        :red
      elsif r < 5 and g < 5 and b > 250
        :blue
      elsif r < 5 and g < 5 and b < 5
        :black
      else
        raise "I don't know the color #{self.inspect}"
      end
    end
  end

  def rgb(color)
    Color.new(
      ChunkyPNG::Color.r(color),
      ChunkyPNG::Color.g(color),
      ChunkyPNG::Color.b(color)
    )
  end
end
