Pod::Spec.new do |s|
  s.name             = "HJThemeModel"
  s.version          = "0.1"
  s.summary          = "A library for backporting Color Mode in iOS"

  s.description      = <<-DESC
                       HJThemeModel provides a mechanism to support dark mode for apps on iOS 9+.
                       DESC
  s.homepage         = "https://github.com/HJyuge/HJFluentTheme"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "HuangJin"
  s.source           = { :git => "https://github.com/HJyuge/HJFluentTheme.git"}
  s.platform         = :ios, '11.0'
  s.requires_arc     = true
  s.frameworks       = 'UIKit', 'Foundation'
  s.swift_version    = '4.0'
  s.ios.deployment_target = '9.0'


  s.subspec 'THemeModelCore' do |ss|
    s.source_files     = 'Sources/THemeModelCore/*.{h,m}'
    
  s.subspec 'THemeModelKit' do |ss|
    s.source_files     = 'Sources/THemeModelKit/**/*.swift'

end
