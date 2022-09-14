# yt-dlp

Wrapper for the [yt-dlp](https://github.com/yt-dlp/yt-dlp) video download tool. This gem is heavily inspired by the youtube_dl.rb gem

![CI](https://github.com/andrepcg/yt-dlp.rb/workflows/CI/badge.svg)


## Install the gem

Add this line to your application's Gemfile:

```ruby
gem 'yt-dlp.rb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yt-dlp.rb

## Install yt-dlp
This gem ships with the latest (working) version of yt-dlp built-in, so you don't have to install yt-dlp at all! Unless you want to.

Some features of yt-dlp require ffmpeg or avconf to be installed.  Normally these are available for installation from your distribution's repositories.

## Usage

Pretty simple.

```ruby
YtDlp.download "https://www.youtube.com/watch?v=gvdf5n-zI14", output: 'some_file.mp4'
```

All options available to yt-dlp can be passed to the options hash

```ruby
options = {
  username: 'someone',
  password: 'password1',
  rate_limit: '50K',
  format: :worst,
  continue: false
}

YtDlp.download "https://www.youtube.com/watch?v=gvdf5n-zI14", options
```

Options passed as `options = {option: true}` or `options = {option: false}` are passed to yt-dlp as `--option` or `--no-option`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Pass test suite (`rake test`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

Remember: commit now, commit often.
