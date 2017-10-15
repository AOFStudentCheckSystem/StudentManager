platform :ios, '10.0'
inhibit_all_warnings!
use_frameworks!
target 'SystemManager' do
  use_frameworks!
  
  pod 'Alamofire', '~> 4.5'
  pod 'StaticDataTableViewController', '~> 2.0.5'
  pod 'Alertift', '~> 3.0'
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
#        if target.name == '<insert target name of your pod here>'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
 #       end
    end
  end
end
