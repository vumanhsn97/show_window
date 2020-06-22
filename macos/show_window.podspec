#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'show_window'
  s.version          = '0.0.1'
  s.summary          = 'Provides access to the macOS show window.'
  s.description      = <<-DESC
Provides access to the macOS show window.
                       DESC
  s.homepage         = 'https://github.com/vumanhsn97/show_window'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'InspireUI Developers' => 'support@inspireui.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx
  s.osx.deployment_target = '10.11'
end

