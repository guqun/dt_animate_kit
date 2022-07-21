//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dt_animate_kit/dt_animate_kit_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dt_animate_kit_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DtAnimateKitPlugin");
  dt_animate_kit_plugin_register_with_registrar(dt_animate_kit_registrar);
}
