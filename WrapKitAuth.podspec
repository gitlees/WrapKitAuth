Pod::Spec.new do |spec|

  spec.name         = "WrapKitAuth"
  spec.version      = "0.0.1"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = "Simple networking module consisted of http client with url session implementation"

  spec.homepage     = "https://github.com/gitlees/WrapKitAuth"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "gitlees" => "glees769@gmail.com" }

  spec.ios.deployment_target = "12.0"
  spec.osx.deployment_target = "10.14"
  spec.swift_version = "5.0"

  spec.source        = { :git => "https://github.com/gitlees/WrapKitAuth.git", :tag => "#{spec.version}" }
  spec.source_files  = "Sources/WrapKitAuth/**/*.{h,m,swift}"

end
