Pod::Spec.new do |s|

  s.name         = "Alamofire-Prephirences"
  s.version      = "2.0.0"
  s.summary      = "Remote preferences and configuration for your application"
  s.homepage    = "https://github.com/phimage/Alamofire-Prephirences"
  s.license     = { :type => "MIT" }
  s.author             = { "phimage" => "eric.marchand.n7@gmail.com" }
  s.osx.deployment_target = "10.11"
  s.ios.deployment_target = "9.0"
  s.tvos.deployment_target = "9.0"

  s.source = { :git => "https://github.com/phimage/Alamofire-Prephirences.git", :tag => s.version }
  s.source_files = "Sources/*.swift"

  s.dependency 'Alamofire', "~> 4.0"
  s.dependency 'Prephirences', "~> 3.0"

end
