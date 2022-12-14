# frozen_string_literal: true

module YtDlp
  # Video model for using and downloading a single video.
  class Video < Runner
    class << self
      # Instantiate a new Video model and download the video
      #
      #   YtDlp.download 'https://www.youtube.com/watch?v=KLRDLIIl8bA' # => #<YtDlp::Video:0x00000000000000>
      #   YtDlp.get 'https://www.youtube.com/watch?v=ia1diPnNBgU', extract_audio: true, audio_quality: 0
      #
      # @param url [String] URL to use and download
      # @param options [Hash] Options to pass in
      # @return [YtDlp::Video] new Video model
      def download(url, options = {})
        video = new(url, options)
        video.download(false)
        video
      end
      alias get download


      def dowload_with_information(url, options = {})
        video = new(url, options.merge(with_information: true))
        video.download(true)
      end

      def information(url, options = {})
        video = new(url, options)
        video.information
      end
    end

    # @return [YtDlp::Options] Download Options for the last download
    attr_reader :download_options

    # Instantiate new model
    #
    # @param url [String] URL to initialize with
    # @param options [Hash] Options to populate the everything with
    def initialize(url, options = {})
      @url = url
      @with_information = options[:with_information].presence || false
      @options = @with_information ? YtDlp::Options.new(options.except(:with_information)) : YtDlp::Options.new(options.merge(default_options))
      @options.banned_keys = banned_keys
    end

    # Download the video.
    def download(with_information)
      raise ArgumentError, 'url cannot be nil' if @url.nil?
      raise ArgumentError, 'url cannot be empty' if @url.empty?

      if with_information
        YtDlp::Runner.new(url, runner_options.with({ print_traffic: true })).run
      else
        set_information_from_json(YtDlp::Runner.new(url, runner_options).run)
      end
    end
    alias get download


    # Returns the expected filename
    #
    # @return [String] Filename downloaded to
    def filename
      _filename
    end

    # Metadata information for the video, gotten from --print-json
    #
    # @return [OpenStruct] information
    def information
      @information || grab_information_without_download
    end

    # Redirect methods for information getting
    #
    # @param method [Symbol] method name
    # @param args [Array] method arguments
    # @param block [Proc] explict block
    # @return [Object] The value from @information
    def method_missing(method, *args, &block)
      value =
        if information.is_a?(Array)
          information.first[method]
        else
          information[method]
        end

      if value.nil?
        super
      else
        value
      end
    end

    private

    # Add in other default options here.
    def default_options
      {
        color: false,
        progress: false,
        print_json: true
      }
    end

    def banned_keys
      %i[
        get_url
        get_title
        get_id
        get_thumbnail
        get_description
        get_duration
        get_filename
        get_format
      ]
    end

    def runner_options
      options = @with_information ? @options.to_h : @options.to_h.merge(default_options)

      YtDlp::Options.new(options)
    end

    def set_information_from_json(json) # :nodoc:
      @information =
        if json.include?("\n")
          json.split("\n").collect do |root_node|
            JSON.parse(root_node, symbolize_names: true)
          end
        else
          JSON.parse(json, symbolize_names: true)
        end
    end

    def grab_information_without_download # :nodoc:
      set_information_from_json(YtDlp::Runner.new(url, runner_options.with({ skip_download: true })).run)
    end
  end
end
