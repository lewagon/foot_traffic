require "foot_traffic"
using FootTraffic

FootTraffic::Session.start do |window|
  window.tab_thread { |tab| tab.goto "https://www.lewagon.com" }
  window.tab_thread { |tab| tab.goto "https://www.lewagon.com/berlin" }
  window.tab_thread { |tab| tab.goto "https://www.lewagon.com/paris" }
end
