Pod::Spec.new do |s|
    s.name             = 'NSideMenu'
    s.version          = '1.0.1'
    s.summary          = 'A simple customizable side menu written in SwiftUI.'
    s.homepage         = 'https://github.com/itisnajim/NSideMenu'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'itisnajim' => 'itisnajim@gmail.com' }
    s.social_media_url = 'https://twitter.com/ItisNajim'
    s.source           = { :git => 'https://github.com/itisnajim/NSideMenu.git', :tag => s.version.to_s }
    s.ios.deployment_target = '13.0'
    s.swift_version = '5.0'
    s.source_files = 'Sources/NSideMenu/**/*'
end
