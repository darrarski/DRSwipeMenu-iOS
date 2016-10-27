Pod::Spec.new do |s|
  s.name                  = 'DRSwipeMenu'
  s.version               = '2.0.4'
  s.summary               = 'Customizable swipe-to-reveal menu for iOS apps'
  s.homepage              = 'https://github.com/darrarski/DRSwipeMenu-iOS'
  s.author                = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.social_media_url      = 'https://twitter.com/darrarski'
  s.license               = { :type => 'MIT', 
                              :file => 'LICENSE' }
  s.source                = { :git => 'https://github.com/darrarski/DRSwipeMenu-iOS.git', 
                              :tag => 'v' + s.version }
  s.platform              = :ios
  s.ios.deployment_target = '8.0'
  s.source_files          = 'DRSwipeMenu'
  s.requires_arc          = true
end
