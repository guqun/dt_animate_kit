#ifndef FLUTTER_PLUGIN_DT_ANIMATE_KIT_PLUGIN_H_
#define FLUTTER_PLUGIN_DT_ANIMATE_KIT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace dt_animate_kit {

class DtAnimateKitPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DtAnimateKitPlugin();

  virtual ~DtAnimateKitPlugin();

  // Disallow copy and assign.
  DtAnimateKitPlugin(const DtAnimateKitPlugin&) = delete;
  DtAnimateKitPlugin& operator=(const DtAnimateKitPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace dt_animate_kit

#endif  // FLUTTER_PLUGIN_DT_ANIMATE_KIT_PLUGIN_H_
