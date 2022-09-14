# frozen_string_literal: true

require 'terrapin'
require 'json'
require 'ostruct'

require 'yt-dlp/version'
require 'yt-dlp/support'
require 'yt-dlp/options'
require 'yt-dlp/runner'
require 'yt-dlp/video'

# Global YtDlp module. Contains some convenience methods and all of the business classes.
module YtDlp
  extend self
  extend Support

  # Downloads given array of URLs with any options passed
  #
  # @param urls [String, Array] URLs to download
  # @param options [Hash] Downloader options
  # @return [YtDlp::Video, Array] Video model or array of Video models
  def download(urls, options = {})
    if urls.is_a? Array
      urls.map { |url| YtDlp::Video.get(url, options) }
    else
      YtDlp::Video.get(urls, options) # Urls should be singular but oh well. url = urls. There. Go cry in a corner.
    end
  end

  alias get download

  def information(urls, options = {})
    if urls.is_a? Array
      urls.map { |url| YtDlp::Video.information(url, options) }
    else
      YtDlp::Video.information(urls, options) # Urls should be singular but oh well. url = urls. There. Go cry in a corner.
    end
  end

  # Lists extractors
  #
  # @return [Array] list of extractors
  def extractors
    @extractors ||= terrapin_line('--list-extractors').run.split("\n")
  end

  # Returns yt-dlp's version
  #
  # @return [String] yt-dlp version
  def binary_version
    @binary_version ||= terrapin_line('--version').run.strip
  end

  # Returns user agent
  #
  # @return [String] user agent
  def user_agent
    @user_agent ||= terrapin_line('--dump-user-agent').run.strip
  end
end
