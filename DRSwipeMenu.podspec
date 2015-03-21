Pod::Spec.new do |s|
  s.name         = 'DRSwipeMenu'
  s.version      = '1.0.0'
  s.summary      = ''
  s.homepage     = 'https://github.com/darrarski/DRSwipeMenu-iOS'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'Dariusz Rybicki' => 'darrarski@gmail.com' }
  s.source       = { :git => 'https://github.com/darrarski/DRSwipeMenu-iOS', :tag => 'v1.0.0' }
  s.platform     = :ios
  s.source_files = 'DRSwipeMenu'
  s.requires_arc = true
end
