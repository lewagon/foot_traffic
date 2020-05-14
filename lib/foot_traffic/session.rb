require_relative "refinements"
require "ferrum"

module FootTraffic
  class ThreadPool
    def initialize
      @threads = []
    end

    def <<(thread)
      @threads << thread
    end

    def wait
      @threads.map(&:join)
    end
  end

  class Session
    def self.start(options: {}, duration: nil, clones: 1, quit: false, &block)
      new(options).start(duration: duration, clones: clones, quit: quit, &block)
    end

    def initialize(opts)
      opts[:headless] ||= false
      @browser ||= Ferrum::Browser.new(opts)
    end

    def start(duration: nil, clones: 1, quit: false, &block)
      main = Thread.new {
        threads = []
        clones.times do
          threads << Thread.new {
            window = @browser.contexts.create
            block.call(window, ThreadPool.new)
          }
        end
        threads.map(&:join)
      }

      # A sleeping thread to keep Ferrum open for a given period of time
      unless quit
        wait = Thread.new {
          duration.nil? ? sleep : sleep(duration)
        }
        wait.join
      end

      main.join
      @browser.quit
    rescue ThreadError, RuntimeError, Errno::EMFILE, Errno::ECONNRESET
      raise ResourceOverloadError
    end
  end
end
