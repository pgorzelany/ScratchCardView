#
# Be sure to run `pod lib lint ScratchCardView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScratchCardView'
  s.version          = '1.0.0'
  s.summary          = 'A scratch card view for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A scratch card view for iOS. Scratch card made easy!
                       DESC

  s.homepage         = 'https://github.com/pgorzelany/ScratchCardView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pgorzelany' => 'piotr.gorzelany@gmail.com' }
  s.source           = { :git => 'https://github.com/pgorzelany/ScratchCardView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/PGorzelany'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ScratchCardView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ScratchCardView' => ['ScratchCardView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
