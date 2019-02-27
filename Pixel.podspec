#  Validate Podspec by running 'pod spec lint Pixel.podspec'
#  Podspec attributes : http://docs.cocoapods.org/specification.html
#  Podspecs examples : https://github.com/CocoaPods/Specs/

Pod::Spec.new do |s|

    s.name         = "Pixel"
    s.version      = "1.0.0"
    s.summary      = "A collection of classes, protocols and extensions that enrich UIKit & Texture"
    s.description  = <<-DESC
						`Pixel` brings new classes, protocols and extensions to `UIKit` and `Texture` to boost your productivity.
                        DESC
    s.homepage     = "https://github.com/iDonJose/Pixel"
    s.source       = { :git => "https://github.com/iDonJose/Pixel.git", :tag => "#{s.version}" }

    s.license      = { :type => "Apache 2.0", :file => "LICENSE" }

    s.author       = { "iDonJose" => "donor.develop@gmail.com" }


    s.ios.deployment_target = "9.0"


	s.subspec 'Core' do |core|
		core.frameworks = "Foundation", "UIKit"
		core.source_files  = "Sources/**/*.{h,swift}"
	end

	s.subspec 'Texture' do |texture|
		texture.dependency 'Pixel/Core'
		texture.dependency "Texture/Core", "~> 2.7"
		texture.xcconfig = { "OTHER_SWIFT_FLAGS" => "-D USE_TEXTURE" }
	end

	s.subspec 'SVG' do |svg|
		svg.dependency 'Pixel/Core'
		svg.dependency "SVGPath", "~> 1.0"
		svg.xcconfig = { "OTHER_SWIFT_FLAGS" => "-D USE_SVG" }
	end

	s.default_subspecs = 'Core', 'Texture', 'SVG'

end
