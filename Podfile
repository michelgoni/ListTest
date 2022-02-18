# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/michelgoni/TransportProjectSpecs.git'

target 'List' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for List
  pod 'TransportsUI'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'NSObject+Rx'
  pod 'Action'
  pod 'RxSwiftExt', '~> 5'
  pod 'RxDataSources', '~> 4.0'
  pod 'RxKingfisher'
  pod 'Moya/RxSwift'
  
  target 'ListTests' do
    inherit! :search_paths
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            if target.name == "Nimble"
                target.build_configurations.each do |config|
                    xcconfig_path = config.base_configuration_reference.real_path
                    xcconfig = File.read(xcconfig_path)
                    new_xcconfig = xcconfig.sub('lswiftXCTest', 'lXCTestSwiftSupport')
                    File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
                end
            end
        end
    end
    # Pods for testing
    pod 'RxBlocking'
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
    
  end
end

target 'DomainLayer' do
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'DomainLayerTests' do
  use_frameworks!
  pod 'RxBlocking'
  pod 'Quick'
  pod 'Nimble'
  pod 'RxTest'
end

target 'DataLayer' do
  use_frameworks!
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
end

