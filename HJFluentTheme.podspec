Pod::Spec.new do |s|
  s.name             = "HJFluentTheme"
  s.version          = "0.1"
  s.summary          = "A library for backporting Color Mode in iOS"

  s.description      = <<-DESC
                       HJFluentTheme provides a mechanism to support dark mode for apps on iOS 11+ (including iOS 13).
                       DESC
  s.homepage         = "https://github.com/HJyuge/HJFluentTheme"
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = "HuangJin"
  s.source           = { :git => "https://github.com/HJyuge/HJFluentTheme.git", :tag => s.version.to_s }
  s.platform         = :ios, '11.0'
  s.requires_arc     = true
  s.frameworks       = 'UIKit', 'Foundation'
  s.swift_version    = '4.0'

  s.source_files     = 'Sources/DarkModeCore/*.{h,m}', 'Sources/FluentDarkModeKit/**/*.swift'
end
