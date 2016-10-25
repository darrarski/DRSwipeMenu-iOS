Pod::Spec.new do |s|
  s.name         = 'DRSwipeMenu'
  s.version      = '2.0.2'
  s.summary      = 'Customizable swipe-to-reveal menu for iOS apps'
  s.homepage     = 'https://github.com/darrarski/DRSwipeMenu-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.source       = { :git => 'https://github.com/darrarski/DRSwipeMenu-iOS.git', :tag => 'v2.0.2' }
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source_files = 'DRSwipeMenu'
  s.requires_arc = true
end
