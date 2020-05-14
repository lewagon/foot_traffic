require "concurrent" # concurrent-ruby

tokens = [] # imaginary array of auth tokens

cookies = Concurrent::Hash.new

opts = {
  headless: false, # Headless or not
  timeout: 300, # How long to wait for new tab to open, set for high value
  slowmo: 0.1, # How fast do you want bots to type
  window_size: [1200, 800]
}

FootTraffic::Session.start(options: opts, quit: true) do |window, pool|
  tokens.each do |token|
    sleep(1) # Need to sleep so we can propely save cookies
    pool << window.with_tab { |tab|
      tab.goto("https://example.com/sign_in/#{token}")
      cookies[token] = tab.cookies["_example_session"].value
    }
  end
  pool.wait
end

FootTraffic::Session.start(options: opts) do |window|
  tokens.each do |token|
    sleep(1) # Wait to properly load cookies
    window.with_tab do |tab|
      tab.cookies.clear
      tab.cookies.set(
        name: "_example_session",
        domain: "example.lewagon.co",
        value: cookies[token]
      )
      tab.goto("https://example.com/protected_route")
    end
  end
end
