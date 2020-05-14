require "foot_traffic"
using FootTraffic

FootTraffic::Session.start do |window|
  window.tab_thread { |tab| tab.goto "https://www.lewagon.com" }
  window.tab_thread { |tab| tab.goto "https://www.lewagon.com/berlin" }
  window.tab_thread do |paris|
    paris.goto "https://www.lewagon.com/paris"
    paris.at_css('[href="/paris/apply"]').click
    paris.at_css("#apply_first_name").focus.type("Alan")
    paris.at_css("#apply_last_name").focus.type("Turing", :Tab)
  end
end
