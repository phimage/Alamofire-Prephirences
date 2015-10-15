Pod::Spec.new do |s|

  s.name         = "Alamofire-Prephirences"
  s.version      = "1.0.0"
  s.summary      = "Remote preference and configuration for your application"
  s.homepage    = "https://github.com/phimage/Alamofire-Prephirences"
  s.license     = { :type => "MIT" }
  s.author             = { "phimage" => "eric.marchand.n7@gmail.com" }
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "8.0"

  s.source = { :git => "https://github.com/phimage/Alamofire-Prephirences.git", :tag => s.version }
  s.source_files = "Alamofire-Prephirences/*.swift"

  s.dependency 'Alamofire', "~> 3.0"
  s.dependency 'Prephirences', "~> 2.0"

end
