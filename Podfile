# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/michelgoni/TransportProjectSpecs.git'

target 'List' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for List
  pod 'TransportationApiClient', '0.1.3'
  pod 'TransportsUI'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'NSObject+Rx'
  pod 'Action'
  pod 'RxDataSources', '~> 4.0'
  pod 'RxKingfisher'
  
  target 'ListTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking'
    pod 'Quick'
    pod 'Nimble'
    pod 'RxTest'
  end
  
end
