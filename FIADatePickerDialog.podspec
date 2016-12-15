Pod::Spec.new do |spec|
  spec.name = "FIADatePickerDialog"
  spec.version = "1.0.0"
  spec.summary = "Usefull DatePicker dialog"
  spec.homepage = "https://futureinapps.com"
  spec.license = {type:'MIT',file:'LICENSE'}
  spec.authors = { "Ayrat Galiullin" => 'info@futureinapps.com' }
  spec.social_media_url = "https://vk.com/futureinapps"
  spec.platform = :ios, "10.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/futureinapps/FIADatePickerDialog.git",tag: "#{spec.version}",submodules:true}
  spec.source_files = "FIADatePickerDialog","FIADatePickerDialog/**/*.{h,m,swift}"
end
