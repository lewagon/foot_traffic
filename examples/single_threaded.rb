require "foot_traffic"
using FootTraffic

FootTraffic::Session.start do |window|
  window.new_tab.goto "https://www.lewagon.com"
  window.new_tab.goto "https://www.lewagon.com/berlin"

  paris = window.new_tab
  paris.goto "https://www.lewagon.com/paris"
  paris.at_css('[href="/paris/apply"]').click
  paris.at_css("#apply_first_name").focus.type("Alan")
  paris.at_css("#apply_last_name").focus.type("Turing", :Tab)
end
