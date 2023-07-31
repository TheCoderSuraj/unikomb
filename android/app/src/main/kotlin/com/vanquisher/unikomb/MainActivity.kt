package com.vanquisher.unikomb

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}
//Added by skyular 6194
function onReady(assets) {
  const picker = NativeUI.picker;

  const index = 0;
  const selection = 0;

  const configuration = {
    selectedIndex: index,

    items: [
      { image_texture: texture0 },
      { image_texture: texture1 },
      { image_texture: texture2 },
    ],
  };

  picker.configure(configuration);
  picker.visible = true;

  picker.selectedIndex.monitor().subscribe(function (index) {
    Patches.inputs.setScalar("selection", index.newValue);
  });
}
