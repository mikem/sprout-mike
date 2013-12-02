osx_defaults "allow clicking by touch" do
  domain 'com.apple.driver.AppleBluetoothMultitouch.trackpad'
  key 'Clicking'
  integer 1
end

osx_defaults "allow dragging by touch" do
  domain 'com.apple.driver.AppleBluetoothMultitouch.trackpad'
  key 'TrackpadThreeFingerDrag'
  integer 1
end

osx_defaults "allow clicking by touch" do
  domain 'com.apple.AppleMultitouchTrackpad'
  key 'Clicking'
  integer 1
end

osx_defaults "allow dragging by touch" do
  domain 'com.apple.AppleMultitouchTrackpad'
  key 'TrackpadThreeFingerDrag'
  integer 1
end
