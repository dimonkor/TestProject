Pod::Spec.new do |spec|
    spec.name = 'CoallaSDK'
    spec.version = '1.0'
    spec.platform = :ios
    spec.source = { :git => 'git@coalla.ru:coalla_iphone' }
    spec.source_files = 'Coalla'
    spec.requires_arc = true
end