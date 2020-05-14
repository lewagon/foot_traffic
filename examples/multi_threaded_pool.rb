require "foot_traffic"
using FootTraffic

FootTraffic::Session.start(quit: true) do |window, pool|
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
