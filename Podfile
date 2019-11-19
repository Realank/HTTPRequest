platform :ios, '9.0'
use_frameworks!

target 'HTTPRequest' do
	pod 'AMap2DMap' #2D地图SDK(2D地图和3D地图不能同时使用)
	pod 'AMapSearch' #搜索服务SDK
	pod 'MBProgressHUD'
end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        if target.name == 'HTTPRequest'
            target.build_configurations.each do |config|
                xcconfig_path = config.base_configuration_reference.real_path
                xcconfig = File.read(xcconfig_path)
                new_xcconfig = xcconfig.sub('stdc++.6.0.9', 'c++')
                File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
            end
        end
    end
end
