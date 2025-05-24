#
# Be sure to run `pod lib lint babool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Babool'
  s.version          = '1.0.0'
  s.summary          = 'Dev Logging Tool'
  s.description      = <<-DESC
  Babool is unnessary yet very usefull tool while doing the development, you always need a
                       DESC

  s.homepage         = 'https://github.com/greenSyntax/babool-ios'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Abhishek Ravi' => 'ab.abhishek.ravi@gmail.com' }
  s.source           = { :git => 'https://github.com/greenSyntax/babool-ios', :tag => s.version.to_s }
  s.ios.deployment_target = '13.0'
  s.source_files = 'babool/Classes/**/*'
  s.dependency 'GoogleSignIn'
  s.dependency 'GTMSessionFetcher'
end
