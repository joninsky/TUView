#
# Be sure to run `pod lib lint TUView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "TUView"
  s.version          = "0.1.2"
  s.summary          = "TUView lets you instantiate a UIView with an array of image assest that serve as a tutorial for your app."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
When you download a new app there is usually a quick intro page that shows you a pagnated set of images that describe basic set up instructions and/or functionality of the app. This pod lets you duplicate that anywhere in your app! You instantiate the TUView and pass it an array of image assets. You can then present and dismiss it on any view in your app.
                       DESC

  s.homepage         = "https://github.com/joninsky/TUView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Jon Vogel" => "joninsky@gmail.com" }
  s.source           = { :git => "https://github.com/joninsky/TUView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'TUView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
