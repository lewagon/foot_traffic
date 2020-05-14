require "foot_traffic"
using FootTraffic

opts = {
  headless: true,
  process_timeout: 10,
  timeout: 100,
  slowmo: 0.1,
  window_size: [1024, 768]
}

begin
  FootTraffic::Session.start(options: opts, quit: true, clones: 100) do |window, pool|
    pool << window.tab_thread { |tab| tab.goto "https://www.lewagon.com" }
    pool << window.tab_thread { |tab| tab.goto "https://www.lewagon.com/berlin" }
    pool << window.tab_thread { |paris|
      paris.goto "https://www.lewagon.com/paris"
      paris.at_css('[href="/paris/apply"]').click
      paris.at_css("#apply_first_name").focus.type("Alan")
      paris.at_css("#apply_last_name").focus.type("Turing", :Tab)
    }
    pool.wait
  end
rescue FootTraffic::ResourceOverloadError
  puts "Oops..."
  exit(1)
end
