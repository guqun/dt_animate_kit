#include "include/dt_animate_kit/dt_animate_kit_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "dt_animate_kit_plugin.h"

void DtAnimateKitPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  dt_animate_kit::DtAnimateKitPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
