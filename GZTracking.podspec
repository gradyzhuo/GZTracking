Pod::Spec.new do |s|
s.name         = "GZTracking"
s.version      = "1"
s.summary      = "Hello World"
s.description  = <<-DESC
This Framework allows you Integrate any analytics services easily.
DESC
s.homepage     = "http://flin.gy"
s.license      = { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "Grady Zhuo" => "gradyzhuo@gmail.com" }
s.social_media_url = "https://www.facebook.com/gradyzhuo"
s.source       = { :git => "https://github.com/gradyzhuo/GZTracking", :tag => s.version.to_s }
s.platform     = :ios, '8.0'
s.requires_arc = true
s.source_files = 'Source/**/*'
#s.ios.vendored_frameworks = 'Frameworks/*'
s.frameworks   = 'Foundation'
s.vendored_frameworks = 'FBSDKCoreKit'
s.dependency 'Mixpanel', '~> 2.8'
s.dependency 'FBSDKCoreKit', '~> 4.6.0-beta1'
end
