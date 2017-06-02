# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'
#  source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'RxSwift'
            target.build_configurations.each do |config|
#                if config.name == 'Debug'
                    config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D',
                    'TRACE_RESOURCES']
#                end
            end
        end
    end
end

target 'E-ponto' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for E-ponto
	pod 'Firebase/Core'
	pod 'Firebase/Auth'
	pod 'IQKeyboardManagerSwift'
	pod 'RxSwift',    '~> 3.0'
	pod 'RxCocoa',    '~> 3.0'

	

end
