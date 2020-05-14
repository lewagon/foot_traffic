require "ferrum"

module FootTraffic
  refine Ferrum::Context do
    def new_tab
      create_page
    end

    def in_thread(&block)
      Thread.new do
        block.call(create_page)
      rescue ThreadError, RuntimeError, Errno::EMFILE, Errno::ECONNRESET
        raise ResourceOverloadError
      end
    end

    alias_method :with_tab, :in_thread
    alias_method :tab_thread, :in_thread
  end
end
