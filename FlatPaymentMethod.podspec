Pod::Spec.new do |s|
    s.name             = 'FlatPaymentMethod'
    s.version          = '0.0.1'
    s.summary          = 'Flat designed payment input.'
    s.description      = 'Flat designed project aimed at streamlining the input of payment methods'
    s.homepage         = 'https://github.com/educrate/payment-method-ios'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'christianampe' => 'christianampe.work@gmail.com' }
    s.source           = { :git => 'https://github.com/educrate/payment-method-ios.ios', :tag => s.version.to_s }
    s.platform              = :ios
    s.ios.deployment_target = '9.3'
    s.swift_version         = '4.1'
    s.source_files = 'FlatPaymentMethod/Classes/**/*'
    s.dependency 'PaymentValidator', '~> 0.0.6'
    s.dependency 'FlatCreditCard', '~> 0.0.4'
end
