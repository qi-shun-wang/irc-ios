# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'intelligent-remote-control' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for intelligent-remote-control	 
  pod 'SlideMenuControllerSwift', :git => 'https://github.com/dekatotoro/SlideMenuControllerSwift', :branch => 'swift4'
  pod 'Kingfisher', '~> 4.1'
  pod 'SnapKit', '~> 4.0'
  
  target 'intelligent-remote-controlTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'intelligent-remote-controlUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
   installer.pods_project.targets.each do |target|
       target.build_configurations.each do |config|
           config.build_settings['ENABLE_BITCODE'] = 'NO'
           config.build_settings['SWIFT_VERSION'] = '4.0'
       end
   end
end
